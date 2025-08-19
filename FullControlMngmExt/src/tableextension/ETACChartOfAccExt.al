tableextension 50204 ETACChartOfAccExt extends "G/L Account"
{

    trigger OnBeforeInsert()
    begin
        Grec_MngmTableRec.SetRange("User ID", UserId());
        Grec_MngmTableRec.SetRange("Source Table", Grec_MngmTableRec."Source Table"::"G/L Account");
        If Grec_MngmTableRec.FindSet() then
            repeat
                if Grec_MngmTableRec."Insert Record" = true then
                    Message('Current user cannot insert a record on Chart of Accounts page. Please review Control Management Page');
                Error('Current user cannot insert a record on Chart of Accounts page. Please review Control Management Page');
            until Grec_MngmTableRec.Next() = 0;
    end;

    trigger OnBeforeDelete()
    begin
        Grec_MngmTableRec.SetRange("User ID", UserId());
        if Grec_MngmTableRec.FindSet() then begin
            repeat
                if Grec_MngmTableRec."Select All" then
                    Gcdu_AllCustomerDeleteCodeunit.AllGlEntriesDelete(UserId());
            until Grec_MngmTableRec.Next() = 0;
        end else
            Grec_MngmTableRec.SetRange("User ID", UserId());
        Grec_MngmTableRec.SetRange("Source No.", Rec."No.");
        If Grec_MngmTableRec.FindSet() then
            repeat
                if Grec_MngmTableRec."Delete Record" then
                    Message('Current user cannot delete a record on the G/L account page. Please review Control Management Page');
                Error('Current user cannot delete a record on the G/L account page. Please review Control Management Page');
            until Grec_MngmTableRec.Next() = 0;
    end;

    var
        Grec_MngmTableRec: Record ETAC_CustVendControlMngmTable;
        Gcdu_AllCustomerDeleteCodeunit: Codeunit ETACPermissionCodeUnit;
}


