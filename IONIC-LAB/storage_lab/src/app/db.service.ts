import { Inject, Injectable } from '@angular/core';
import { LOCAL_STORAGE, StorageService } from 'ngx-webstorage-service';



@Injectable({
  providedIn: 'root'
})
export class DbService {
  // key that is used to access the data in local storageconst
  key = 'local_todolist';

  constructor(@Inject(this.key) private storage: StorageService) { }

  store(chave: string, valor: string){
    const currentTodoList = this.storage.get(this.key) || [];
    currentTodoList.push({chave, valor});
    this.storage.set(this.key, currentTodoList);
    console.log(this.storage.get(this.key) || 'LocaL storage is empty');
  }
}
