import { Grid2, TextField } from "@mui/material";
import React, { useState, useEffect } from "react";
import { useForm, Form } from "../../components/useForm";

const initialFValues = {
  id: 0,
  fullName: "",
  email: "",
  mobile: "",
  city: "",
  gender: "male",
  departmentId: "",
  hiredDate: new Date(),
  isPermanent: false,
};

export default function EmployeeForm() {
  const { values, setValues, handleInputChange } = useForm(initialFValues);

  return (
    <Form>
      <Grid2 container>
        <Grid2 item xs={6}>
          <TextField
            variant="outlined"
            label="Full Name"
            name="fullName"
            value={values.fullName}
            onChange={handleInputChange}
          />
          <TextField
            variant="outlined"
            label="Email"
            name="email"
            value={values.email}
            onChange={handleInputChange}
          />
        </Grid2>
        <Grid2 item xs={6}></Grid2>
      </Grid2>
    </Form>
  );
}
