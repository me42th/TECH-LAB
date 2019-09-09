import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DistinctUntilChangePage } from './distinct-until-change.page';

describe('DistinctUntilChangePage', () => {
  let component: DistinctUntilChangePage;
  let fixture: ComponentFixture<DistinctUntilChangePage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DistinctUntilChangePage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DistinctUntilChangePage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
