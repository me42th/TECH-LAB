import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ObservableHelloWorldPage } from './observable-hello-world.page';

describe('ObservableHelloWorldPage', () => {
  let component: ObservableHelloWorldPage;
  let fixture: ComponentFixture<ObservableHelloWorldPage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ObservableHelloWorldPage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ObservableHelloWorldPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
