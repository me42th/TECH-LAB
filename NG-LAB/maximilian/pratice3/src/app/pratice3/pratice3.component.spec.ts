import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Pratice3Component } from './pratice3.component';

describe('Pratice3Component', () => {
  let component: Pratice3Component;
  let fixture: ComponentFixture<Pratice3Component>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ Pratice3Component ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(Pratice3Component);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
