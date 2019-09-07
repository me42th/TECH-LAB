import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { Subscription } from 'rxjs';


@Component({
  selector: 'app-reactive-form',
  templateUrl: './reactive-form.page.html',
  styleUrls: ['./reactive-form.page.scss'],
})
export class ReactiveFormPage implements OnInit {

  form: FormGroup;
  subs: Subscription[];
  variavelTexto: FormControl;
  variavelNumerica: FormControl;
  constructor() { }

  ngOnInit() {
    this.variavelTexto = new FormControl(null, {
      updateOn: 'blur',
      validators: [Validators.required]
     });
    this.variavelNumerica = new FormControl(null, {
      updateOn: 'change',
      validators: [Validators.required, Validators.min(1)]
    });
    this.form = new FormGroup({
      variavelTexto: this.variavelTexto,
      variavelNumerica: this.variavelNumerica
    });
    this.subs = [
      this.variavelTexto.valueChanges.subscribe(value => console.log(value)),
      this.variavelNumerica.valueChanges.subscribe(value => console.log(value))
    ];
  }
}