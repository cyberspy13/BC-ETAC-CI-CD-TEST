codeunit 50200 ETACPermissionCodeUnit
{
    procedure ETACAllCustomsBlock(UserId: Code[20]; Customer: Record Customer)
    begin

        CtrlRec.SetRange("User ID", UserId());
        CtrlRec.SetRange("Select All", true);
        CtrlRec.SetRange("Source Table", CtrlRec."Source Table"::Customer);

        if CtrlRec.FindFirst() then begin
            if CtrlRec."View Record" then
                Error('Current user does not have access to open Customer Card Page for All Customers. Please review Control Management Page');

            if CtrlRec."Edit Record" then
                Message('Current user does not have access to edit Customer Card Page for All Customers. Please review Control Management Page');
        end;
    end;

    procedure ETACAllVendorsBlock(UserId: Code[20])
    begin
        CtrlRec.SetRange("User ID", UserId);
        CtrlRec.SetRange("Select All", true);
        CtrlRec.SetRange("Source Table", CtrlRec."Source Table"::Vendor);

        if CtrlRec.FindFirst() then begin
            if CtrlRec."View Record" then
                Error('Current user does not have access to open Vendor Card Page for All Vendors. Please review Control Management Page');

            if CtrlRec."Edit Record" then
                Message('Current user does not have access to edit Vendor Card Page for All Vendors. Please review Control Management Page');
        end;
    end;

    procedure ETACAllItemssBlock(UserId: Code[20])
    begin
        CtrlRec.SetRange("User ID", UserId);
        CtrlRec.SetRange("Select All", true);
        CtrlRec.SetRange("Source Table", CtrlRec."Source Table"::Item);

        if CtrlRec.FindFirst() then begin
            if CtrlRec."View Record" then
                Error('Current user does not have access to open Item Card. Please review Control Management Page');

            if CtrlRec."Edit Record" then
                Message('Current user does not have access to open Item Card. Please review Control Management Page');
        end;
    end;

    procedure ETACAllGlBlock(UserId: Code[20])
    begin
        CtrlRec.SetRange("User ID", UserId);
        CtrlRec.SetRange("Select All", true);
        CtrlRec.SetRange("Source Table", CtrlRec."Source Table"::"G/L Account");

        if CtrlRec.FindFirst() then begin
            if CtrlRec."View Record" then
                Error('Current user does not have access to open VChart Of Accont %1.', CtrlRec."Source No.");

            if CtrlRec."Edit Record" then
                Message('Current user does not have access to open VChart Of Accont %1.', CtrlRec."Source No.");
        end;
    end;

    procedure AllCustomerDelete(UserId: Code[20])
    begin
        CtrlRec.SetRange("User ID", UserId());
        CtrlRec.SetRange("Select All", true);
        CtrlRec.SetRange("Source Table", CtrlRec."Source Table"::Customer);

        if CtrlRec.FindFirst() then begin
            if CtrlRec."Delete Record" then
                Error('Current user does not have access to delete Customer Card Page for All Customers. Please review Control Management Page')
        end;
    end;

    procedure AllVendorDelete(UserId: Code[20])
    begin
        CtrlRec.SetRange("User ID", UserId());
        CtrlRec.SetRange("Select All", true);
        CtrlRec.SetRange("Source Table", CtrlRec."Source Table"::Vendor);

        if CtrlRec.FindFirst() then begin
            if CtrlRec."Delete Record" then
                Error('Current user does not have access to delete Vendor Card Page for All Vendors. Please review Control Management Page')
        end;
    end;

    procedure AllItemDelete(UserId: Code[20])
    begin
        CtrlRec.SetRange("User ID", UserId());
        CtrlRec.SetRange("Select All", true);
        CtrlRec.SetRange("Source Table", CtrlRec."Source Table"::Item);

        if CtrlRec.FindFirst() then begin
            if CtrlRec."Delete Record" then
                Error('Current user does not have access to delete Item Card Page for All Vendors. Please review Control Management Page')
        end;
    end;

    procedure AllGlEntriesDelete(UserId: Code[20])
    begin
        CtrlRec.SetRange("User ID", UserId());
        CtrlRec.SetRange("Select All", true);
        CtrlRec.SetRange("Source Table", CtrlRec."Source Table"::"G/L Account");

        if CtrlRec.FindFirst() then begin
            if CtrlRec."Delete Record" then
                Error('Current user does not have permission to delete Chart of Account entry. Please review Control Management Page')
        end;
    end;

    var
        CtrlRec: Record ETAC_CustVendControlMngmTable;
}
