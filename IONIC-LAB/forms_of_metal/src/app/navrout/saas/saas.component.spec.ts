import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SaasComponent } from './saas.component';

describe('SaasComponent', () => {
  let component: SaasComponent;
  let fixture: ComponentFixture<SaasComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SaasComponent ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SaasComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
