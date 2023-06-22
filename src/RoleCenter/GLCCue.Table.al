table 76000 "GLC Cue"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {

        }

        field(10; "Last Run Count"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result");
        }

        field(20; "Last Run Successes"; Integer)
        {
            Caption = 'Last Run Successes';
            BlankZero = true;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result" where("Result Type" = const(Success)));
        }
        field(30; "Last Run Failures"; Integer)
        {
            Caption = 'Last Run Failures';
            BlankZero = true;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result" where("Result Type" = const(Failure)));
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}