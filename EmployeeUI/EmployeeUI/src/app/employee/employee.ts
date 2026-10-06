import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';

interface Employee {
  id?: number;
  name: string;
  email: string;
  department: string;
  phone: string;
}

@Component({
  selector: 'app-employee',
  standalone: true,
  imports: [ReactiveFormsModule],
  templateUrl: './employee.html',
  styleUrl: './employee.css'
})
export class EmployeeComponent implements OnInit {
  employeeForm: FormGroup;
  employees: Employee[] = [];
  isSubmitting = false;
  message = '';

  constructor(
    private fb: FormBuilder,
    private http: HttpClient
  ) {
    this.employeeForm = this.fb.group({
      name: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      department: ['', Validators.required],
      phone: ['', Validators.required]
    });
  }

  ngOnInit(): void {
    this.loadEmployees();
  }

  loadEmployees(): void {
    this.http.get<Employee[]>('http://localhost:5242/api/Employees').subscribe({
      next: (data) => {
        this.employees = data;
      },
      error: (error) => {
        console.error('Error loading employees:', error);
        this.message = 'Unable to load employees from the API.';
      }
    });
  }

  onSubmit(): void {
    if (this.employeeForm.invalid) {
      this.employeeForm.markAllAsTouched();
      return;
    }

    const employee: Employee = this.employeeForm.value;
    this.isSubmitting = true;
    this.message = '';

    this.http.post<Employee>('http://localhost:5242/api/Employees', employee).subscribe({
      next: (savedEmployee) => {
        this.message = 'Employee saved successfully.';
        this.employees = [savedEmployee, ...this.employees];
        this.employeeForm.reset();
        this.isSubmitting = false;
      },
      error: (error) => {
        console.error('Error saving employee:', error);
        this.message = 'Failed to save employee.';
        this.isSubmitting = false;
      }
    });
  }
}