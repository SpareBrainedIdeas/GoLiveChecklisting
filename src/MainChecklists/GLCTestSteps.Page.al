page 76005 "GLC Test Steps"
{
    Caption = 'Checklist Test Steps';
    PageType = List;
    SourceTable = "GLC Test Step";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Category Id"; Rec."Category Id")
                {
                    ToolTip = 'Specifies the value of the Category Id field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Subcategory Id"; Rec."Subcategory Id")
                {
                    ToolTip = 'Specifies the value of the Subcategory Id field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Test Step Id"; Rec."Id")
                {
                    ToolTip = 'Specifies the value of the Test Step Id field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Total Run Time"; Rec."Total Run Time")
                {
                    ToolTip = 'Specifies the value of the Total Run Time field.';
                    ApplicationArea = All;
                }
                field("Last Run Success"; Rec."Last Run Success")
                {
                    ToolTip = 'Specifies the value of the Last Run Success field.';
                    ApplicationArea = All;
                }
                field(Results; Rec.Results)
                {
                    ToolTip = 'Specifies the value of the Results field.';
                    ApplicationArea = All;
                }
                field(Successes; Rec.Successes)
                {
                    ToolTip = 'Specifies the value of the Successes field.';
                    ApplicationArea = All;
                }
                field(Failures; Rec.Failures)
                {
                    ToolTip = 'Specifies the value of the Failures field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
