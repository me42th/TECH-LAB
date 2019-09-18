import { TestBed, async, inject } from '@angular/core/testing';

import { LeaveGuardGuard } from './leave-guard.guard';

describe('LeaveGuardGuard', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [LeaveGuardGuard]
    });
  });

  it('should ...', inject([LeaveGuardGuard], (guard: LeaveGuardGuard) => {
    expect(guard).toBeTruthy();
  }));
});
