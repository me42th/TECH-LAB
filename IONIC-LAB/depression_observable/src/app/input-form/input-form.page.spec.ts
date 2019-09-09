import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { InputFormPage } from './input-form.page';

describe('InputFormPage', () => {
  let component: InputFormPage;
  let fixture: ComponentFixture<InputFormPage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ InputFormPage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InputFormPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
