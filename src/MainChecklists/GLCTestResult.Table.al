table 76004 "GLC Test Result"
{
    Caption = 'GLC Test Result';
    DataClassification = ToBeClassified;
    DrillDownPageId = "GLC Test Result List";
    LookupPageId = "GLC Test Result List";

    fields
    {
        field(1; "Category Id"; Integer)
        {
            Caption = 'Category Id';
            TableRelation = "GLC Category";
        }
        field(2; "Subcategory Id"; Integer)
        {
            Caption = 'Subcategory Id';
            TableRelation = "GLC Subcategory".Id where("Category Id" = field("Category Id"));
        }
        field(3; "Test Step Id"; Integer)
        {
            Caption = 'Test Step Id';
        }
        field(4; Id; Integer)
        {
            Caption = 'Id';
            AutoIncrement = true;
        }
        field(500; "Result Type"; Enum "GLC Result Type")
        {
            Caption = 'Result Type';
        }
        field(501; "Result Text"; Text[2048])
        {
            Caption = 'Result Text';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Category Id", "Subcategory Id", "Test Step Id", "Id")
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
        GLCTestResult: Record "GLC Test Result";
    begin
        GLCTestResult.SetRange("Category Id", Rec."Category Id");
        GLCTestResult.SetRange("Subcategory Id", Rec."Subcategory Id");
        GLCTestResult.SetRange("Test Step Id", Rec."Test Step Id");
        GLCTestResult.ReadIsolation(IsolationLevel::UpdLock);
        GLCTestResult.SetLoadFields("Id");
        if GLCTestResult.FindLast() then
            exit(GLCTestResult."Id" + 1)
        else
            exit(1);
    end;
}
