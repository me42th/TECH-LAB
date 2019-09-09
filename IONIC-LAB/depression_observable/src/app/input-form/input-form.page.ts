import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-input-form',
  templateUrl: './input-form.page.html',
  styleUrls: ['./input-form.page.scss'],
})
export class InputFormPage implements OnInit, OnDestroy {

  constructor() { }
  subs: Subscription[];
  form: FormGroup;
  commentField: FormControl = new FormControl(null, {
    updateOn: 'change',
    validators: [ Validators.required]
  });
  emailField: FormControl = new FormControl(null, {
    updateOn: 'change',
    validators: [Validators.required, Validators.pattern('[^ @]*@[^ @]*')]
    });
  nameField: FormControl = new FormControl(null, {
    updateOn: 'change',
    validators: [Validators.required]
  });

  ngOnDestroy() {
    this.subs.forEach(
      value => value.unsubscribe()
    );
  }

  ngOnInit() {
    this.subs = [
      this.emailField.valueChanges.subscribe(value => console.log(value)),
      this.commentField.valueChanges.subscribe(value => console.log(value)),
      this.nameField.valueChanges.subscribe(value => console.log(value))
    ];
    this.form = new FormGroup({
      comment: this.commentField,
      email: this.emailField,
      name: this.nameField
    });
  }

}
