import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

@Component({
  selector: 'app-form-group',
  templateUrl: './form-group.page.html',
  styleUrls: ['./form-group.page.scss'],
})
export class FormGroupPage implements OnInit {

  form: FormGroup;
  constructor() { }

  onCreate() {
    console.log('go johnny, go');
    alert('hit the road jack');
  }

  ngOnInit() {
    this.form = new FormGroup({
      titleInput: new FormControl('Valor', {
        updateOn: 'blur',
        validators: [Validators.required]
       }),
      shortTextArea: new FormControl(null, {
        updateOn: 'blur',
        validators: [Validators.required, Validators.maxLength(120)]
       }),
      numberInput: new FormControl(null, {
        updateOn: 'blur',
        validators: [Validators.required, Validators.min(1)]
       }),
      fromDate: new FormControl(null, { 
        updateOn: 'blur',
        validators: [Validators.required]
      }),
      toDate: new FormControl(null, { 
        updateOn: 'blur',
        validators: [Validators.required]
      })
    });
  }
}
