table 50200 ETAC_CustVendControlMngmTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(3; "Source Table"; Enum ControlSource)
        {
            Caption = 'Source Table';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Clear("Source Name");
                Clear("Source No.");
            end;
        }
        field(4; "Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = if ("Source Table" = const(Customer)) Customer."No."
            else if ("Source Table" = const(Vendor)) Vendor."No."
            else if ("Source Table" = const(Item)) Item."No."
            else if ("Source Table" = const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate()
            var
                Lrec_Customer: record Customer;
                Lrec_Vendor: record Vendor;
                Lrec_Item: record Item;
                Lrec_GLAcc: record "G/L Account";
            begin
                case "Source Table" of
                    "Source Table"::Customer:
                        if Lrec_Customer.Get("Source No.") then
                            "Source Name" := Lrec_Customer."Name";
                    "Source Table"::Vendor:
                        if Lrec_Vendor.Get("Source No.") then
                            "Source Name" := Lrec_Vendor."Name";
                    "Source Table"::Item:
                        if Lrec_Item.Get("Source No.") then
                            "Source Name" := Lrec_Item.Description;
                    "Source Table"::"G/L Account":
                        if Lrec_GLAcc.Get("Source No.") then
                            "Source Name" := Lrec_GLAcc."Name";
                end;

                if "Select All" = true then begin
                    Error('Please deselect "Select All" before making changes.');
                end;
                Grec_SourceTableRecord.Reset;
                Grec_SourceTableRecord.SetRange("User ID", Rec."User ID");
                Grec_SourceTableRecord.SetRange("Source Table", Rec."Source Table");
                Grec_SourceTableRecord.SetRange("Source No.", Rec."Source No.");
                if Grec_SourceTableRecord.FindFirst() then
                    Error('Source record %1 already exists for this user and source table.', Rec."Source No.");
            end;
        }

        field(15; "Source Name"; Text[100])
        {
            Caption = 'Source Name';
            DataClassification = ToBeClassified;
        }

        field(8; "Select All"; Boolean)
        {
            Caption = 'Select All Customers';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (Rec."Select All" = true) and (Rec."Source No." <> '') then
                    Rec."Source No." := '';
                Rec."Source Name" := '';

                if Rec."Select All" = true then begin
                    Grec_SourceTableRecord.Reset();
                    //Grec_SourceTableRecord.SetRange("No.", Rec."No.");
                    Grec_SourceTableRecord.SetRange("User ID", Rec."User ID");
                    Grec_SourceTableRecord.SetRange("Source Table", Rec."Source Table");
                    Grec_SourceTableRecord.SetRange("Select All", true);
                    if Grec_SourceTableRecord.FindFirst() then
                        Error('Select All option already exists for this %1 Source Record .', Rec."Source Table");
                end;
            end;
        }
        field(11; "View Record"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'View Record';
            trigger OnValidate()
            begin
                if "Edit Record" then
                    "Edit Record" := false;
            end;
        }
        field(12; "Edit Record"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Edit Record';
            trigger OnValidate()
            begin
                if "View Record" then
                    "View Record" := false;
            end;
        }
        field(13; "Delete Record"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Delete Record';
        }
        field(14; "Insert Record"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Insert Record';
            trigger OnValidate()
            begin
                if (Rec."Insert Record" = true) and (Rec."Source No." <> '') then
                    Rec."Source No." := '';
                Rec."Source Name" := '';
            end;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(FK; "Source Table", "Source No.")
        {
            Clustered = false;
        }
    }
    trigger OnInsert()
    begin
        TestField("No.");
        //TestField("User ID");
    end;

    var
        Grec_SourceTableRecord: Record ETAC_CustVendControlMngmTable;
}