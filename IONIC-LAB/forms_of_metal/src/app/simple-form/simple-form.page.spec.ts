import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SimpleFormPage } from './simple-form.page';

describe('SimpleFormPage', () => {
  let component: SimpleFormPage;
  let fixture: ComponentFixture<SimpleFormPage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SimpleFormPage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SimpleFormPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
