import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TrainStopsDialogComponent } from './train-stops-dialog.component';

describe('TrainStopsDialogComponent', () => {
  let component: TrainStopsDialogComponent;
  let fixture: ComponentFixture<TrainStopsDialogComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [TrainStopsDialogComponent]
    });
    fixture = TestBed.createComponent(TrainStopsDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
