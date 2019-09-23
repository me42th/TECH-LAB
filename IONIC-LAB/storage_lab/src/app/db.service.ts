import { Inject, Injectable } from '@angular/core';
import { LOCAL_STORAGE, StorageService } from 'ngx-webstorage-service';
import { BehaviorSubject } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
export class DbService {

  key = 'local';
  private list: string[] = [null];
  _boss: BehaviorSubject<string[]> = new BehaviorSubject(this.list);

  constructor(@Inject(LOCAL_STORAGE) private storage: StorageService) {
    const currentTodoList = this.storage.get(this.key) ||  [];
    this._boss.next(currentTodoList);
   }

  get observable() {
    return this._boss.asObservable();
  }

  store(valor: string) {
    const currentTodoList = this.storage.get(this.key) || [];
    currentTodoList.push({valor});
    this.storage.set(this.key, currentTodoList);
    this._boss.next(currentTodoList);
  }

  del(valor: string) {
    const currentTodoList = this.storage.get(this.key) || [];
    const tempList = currentTodoList.filter(
      item => {
        return item.valor !== valor;
      });
    this.storage.set(this.key, tempList);
    this._boss.next(tempList);
  }

  show() {
    const currentTodoList = this.storage.get(this.key) || [];
    this._boss.next(currentTodoList);
  }
}
