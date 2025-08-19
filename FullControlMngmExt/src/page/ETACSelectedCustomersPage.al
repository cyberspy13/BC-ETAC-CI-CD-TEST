page 50200 ETACSelectedCustomersPage
{
    ApplicationArea = All;
    Caption = 'Control Management System';
    PageType = List;
    SourceTable = ETAC_CustVendControlMngmTable;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    ShowMandatory = true;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                }
                field("Source Table"; Rec."Source Table")
                {
                    ApplicationArea = All;
                    Caption = 'Source Table';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Caption = 'Source No.';
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                    Caption = 'Source Name';
                }
                field("Select All"; Rec."Select All")
                {
                    ApplicationArea = All;
                    Caption = 'Select All';
                }
                field("View Record"; Rec."View Record")
                {
                    ApplicationArea = All;
                    Caption = 'View Record';
                }
                field("Edit Record"; Rec."Edit Record")
                {
                    ApplicationArea = All;
                    Caption = 'Edit Record';
                }
                field("Delete Record"; Rec."Delete Record")
                {
                    ApplicationArea = All;
                    Caption = 'Delete Record';
                }
                field("Insert Record"; Rec."Insert Record")
                {
                    ApplicationArea = All;
                    Caption = 'Insert Record';
                }
            }
        }
    }
}
