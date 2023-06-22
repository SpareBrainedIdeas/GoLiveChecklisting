table 76003 "GLC Test Step"
{
    Caption = 'GLC Test Step';
    DataClassification = ToBeClassified;
    DrillDownPageId = "GLC Test Steps";
    LookupPageId = "GLC Test Steps";

    fields
    {
        field(1; "Category Id"; Integer)
        {
            Caption = 'Category Id';
            DataClassification = ToBeClassified;
            TableRelation = "GLC Category";
        }
        field(2; "Subcategory Id"; Integer)
        {
            Caption = 'Subcategory Id';
            DataClassification = ToBeClassified;
            TableRelation = "GLC Subcategory".Id where("Category Id" = field("Category Id"));
        }
        field(3; Id; Integer)
        {
            Caption = 'Id';
            DataClassification = ToBeClassified;
        }
        field(12; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(15; "Test Codeunit Id"; Integer)
        {
            Caption = 'Test Codeunit Id';
            DataClassification = ToBeClassified;
        }
        field(20; "Total Run Time"; Duration)
        {
            Caption = 'Total Run Time';
            DataClassification = ToBeClassified;
        }
        field(30; "Last Run Success"; Boolean)
        {
            Caption = 'Last Run Success';
            DataClassification = ToBeClassified;
        }
        field(1000; Results; Integer)
        {
            Caption = 'Results';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result" where("Category Id" = field("Category Id"), "Subcategory Id" = field("Subcategory Id"), "Test Step Id" = field(Id)));
        }
        field(1001; Successes; Integer)
        {
            Caption = 'Successes';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result" where("Category Id" = field("Category Id"), "Subcategory Id" = field("Subcategory Id"), "Test Step Id" = field(Id), "Result Type" = const(Success)));
        }
        field(1002; Failures; Integer)
        {
            Caption = 'Failures';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result" where("Category Id" = field("Category Id"), "Subcategory Id" = field("Subcategory Id"), "Test Step Id" = field(Id), "Result Type" = const(Failure)));
        }
    }
    keys
    {
        key(PK; "Category Id", "Subcategory Id", "Id")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if Rec."Id" = 0 then
            Rec."Id" := GetNextStepId();
    end;

    local procedure GetNextStepId(): Integer
    var
        GLCTestStep: Record "GLC Test Step";
    begin
        GLCTestStep.SetRange("Category Id", Rec."Category Id");
        GLCTestStep.SetRange("Subcategory Id", Rec."Subcategory Id");
        if GLCTestStep.FindLast() then
            exit(GLCTestStep."Id" + 1)
        else
            exit(1);
    end;
}
