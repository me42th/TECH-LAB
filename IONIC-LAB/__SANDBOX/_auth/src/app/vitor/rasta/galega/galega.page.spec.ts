import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { GalegaPage } from './galega.page';

describe('GalegaPage', () => {
  let component: GalegaPage;
  let fixture: ComponentFixture<GalegaPage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ GalegaPage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(GalegaPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
