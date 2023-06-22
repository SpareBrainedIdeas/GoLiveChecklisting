page 76007 "GLC Test Result List"
{
    Caption = 'Test Result List';
    PageType = List;
    SourceTable = "GLC Test Result";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Id; Rec."Id")
                {
                    ToolTip = 'Specifies the value of the Id field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Result Type"; Rec."Result Type")
                {
                    ToolTip = 'Specifies the value of the Result Type field.';
                    ApplicationArea = All;
                }
                field("Result Text"; Rec."Result Text")
                {
                    ToolTip = 'Specifies the value of the Result Text field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
