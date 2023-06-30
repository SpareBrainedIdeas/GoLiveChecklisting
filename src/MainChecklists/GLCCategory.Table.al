table 76001 "GLC Category"
{
    Caption = 'GLC Category';
    DataClassification = ToBeClassified;
    DataCaptionFields = Description;

    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(1000; Results; Integer)
        {
            Caption = 'Results';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result" where("Category Id" = field("Id")));
        }
        field(1001; Successes; Integer)
        {
            Caption = 'Successes';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result" where("Category Id" = field("Id"), "Result Type" = const(Success)));
        }
        field(1002; Failures; Integer)
        {
            Caption = 'Failures';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result" where("Category Id" = field("Id"), "Result Type" = const(Failure)));
        }
    }
    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
    }

}
