import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { Css3Component } from './css3.component';

describe('Css3Component', () => {
  let component: Css3Component;
  let fixture: ComponentFixture<Css3Component>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ Css3Component ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Css3Component);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
