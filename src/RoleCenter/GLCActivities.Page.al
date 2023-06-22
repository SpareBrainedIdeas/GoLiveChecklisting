page 76000 "GLC Activities"
{
    Caption = 'Go-Live Checks Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "GLC Cue";
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            cuegroup(LastRunInfo)
            {
                Caption = 'Last Run Information';
                field("Last Run Failures"; Rec."Last Run Failures")
                {
                    ToolTip = 'Specifies the value of the Last Run Successes field.';
                    ApplicationArea = All;
                }
                field("Last Run Successes"; Rec."Last Run Successes")
                {
                    ToolTip = 'Specifies the value of the Last Run Successes field.';
                    ApplicationArea = All;
                }
                field(PassRatePerc; PassRateText)
                {
                    Caption = 'Pass Rate';
                    ToolTip = 'Specifies the total pass rate.';
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        PassRateText: Text;

    trigger OnOpenPage()
    begin
        Rec.Reset();
        If not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

    end;

    trigger OnAfterGetRecord()
    begin
        CalculateCueFieldValues();
    end;

    local procedure CalculateCueFieldValues()
    var
        PassRate: Decimal;
    begin
        Rec.CalcFields("Last Run Count", "Last Run Failures");
        if (Rec."Last Run Count" <> 0) and (Rec."Last Run Failures" <> 0) then
            PassRate := Round(Rec."Last Run Failures" / Rec."Last Run Count", 0.01);
        PassRateText := Format(PassRate) + '%';
    end;

}