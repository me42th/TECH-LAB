import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { FormGroupPage } from './form-group.page';

describe('FormGroupPage', () => {
  let component: FormGroupPage;
  let fixture: ComponentFixture<FormGroupPage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ FormGroupPage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FormGroupPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
