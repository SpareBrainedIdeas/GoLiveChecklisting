table 76002 "GLC Subcategory"
{
    Caption = 'GLC Subcategory';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Category Id"; Integer)
        {
            Caption = 'Category Id';
            DataClassification = ToBeClassified;
        }
        field(2; Id; Integer)
        {
            Caption = 'Id';
            DataClassification = ToBeClassified;
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(100; "Last Run Date"; Date)
        {
            Caption = 'Last Run Date';
            DataClassification = ToBeClassified;
        }
        field(1000; "Test Steps"; Integer)
        {
            Caption = 'Test Steps';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Step" where("Category Id" = field("Category Id"), "Subcategory Id" = field("Id")));
        }
        field(1010; Results; Integer)
        {
            Caption = 'Results';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result" where("Category Id" = field("Category Id"), "Subcategory Id" = field("Id")));
        }
        field(1011; Successes; Integer)
        {
            Caption = 'Successes';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result" where("Category Id" = field("Category Id"), "Subcategory Id" = field("Id"), "Result Type" = const(Success)));
        }
        field(1012; Failures; Integer)
        {
            Caption = 'Failures';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("GLC Test Result" where("Category Id" = field("Category Id"), "Subcategory Id" = field("Id"), "Result Type" = const(Failure)));
        }
    }
    keys
    {
        key(PK; "Category Id", "Id")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin
        if Rec."Id" = 0 then
            Rec."Id" := GetNextSubcategoryId();
    end;

    local procedure GetNextSubcategoryId(): Integer
    var
        GLCSubcategory: Record "GLC Subcategory";
    begin
        GLCSubcategory.SetRange("Category Id", Rec."Category Id");
        GLCSubcategory.ReadIsolation(IsolationLevel::UpdLock);
        GLCSubcategory.SetLoadFields("Id");
        if GLCSubcategory.FindLast() then
            exit(GLCSubcategory."Id" + 1)
        else
            exit(1);
    end;
}
