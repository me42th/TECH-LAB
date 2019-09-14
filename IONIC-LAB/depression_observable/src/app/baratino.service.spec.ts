import { TestBed } from '@angular/core/testing';

import { BaratinoService } from './baratino.service';

describe('BaratinoService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: BaratinoService = TestBed.get(BaratinoService);
    expect(service).toBeTruthy();
  });
});
