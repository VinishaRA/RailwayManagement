import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AdminHomeComponent } from './admin-home/admin-home.component';
import { MaterialModule } from '../material/material.module';
import { FlexLayoutModule } from '@angular/flex-layout';



@NgModule({
  declarations: [
    AdminHomeComponent
  ],
  imports: [
    CommonModule,
    MaterialModule,
    FlexLayoutModule
  ]
})
export class AdminModule { }
