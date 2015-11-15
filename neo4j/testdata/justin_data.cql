begin
create (_0:`Community` {`name`:"Demo 1"})
create (_1:`Issue` {`name`:"Abortion"})
create (_2:`Issue` {`name`:"K-12"})
create (_3:`Issue` {`name`:"Taxes"})
create (_4:`Item` {`name`:"Life"})
create (_5:`Item` {`name`:"Faith"})
create (_6:`Item` {`name`:"Compassion"})
create (_7:`Item` {`name`:"Liberty"})
create (_8:`Item` {`name`:"Reason"})
create (_9:`Item` {`name`:"Outlaw all abortions"})
create (_10:`Item` {`name`:"Expand availability of abortions"})
create (_11:`Item` {`name`:"Restrict access to abortions"})
create (_12:`Item` {`name`:"Maintain access to abortions"})
create (_13:`Item` {`name`:"Reduce unintended pregnancies"})
create (_14:`Item` {`name`:"Overturn Roe v. Wade"})
create (_15:`Item` {`name`:"Ensure access to affordable contraception"})
create (_16:`Item` {`name`:"Enact state-level restrictions to abortions"})
create (_17:`Item` {`name`:"Eliminate federal funding to abortion-related organizations"})
create (_18:`Item` {`name`:"Assert federal authority to assure access to abortions"})
create (_19:`Item` {`name`:"Fund Birth Control Education Programs"})
create (_20:`Item` {`name`:"Maintain Roe v. Wade"})
create (_21:`Item` {`name`:"Repeal state-level restrictions to abortions"})
create (_22:`Community` {`name`:"Demo 2"})
create (_23:`Issue` {`name`:"Abortion"})
create (_24:`Issue` {`name`:"K-12"})
create (_25:`Issue` {`name`:"Taxes"})
create (_26:`Category` {`name`:"Values"})
create (_27:`Category` {`name`:"Objectives"})
create (_28:`Category` {`name`:"Policies"})
create (_29:`Item` {`name`:"Life"})
create (_30:`Item` {`name`:"Faith"})
create (_31:`Item` {`name`:"Compassion"})
create (_32:`Item` {`name`:"Liberty"})
create (_33:`Item` {`name`:"Reason"})
create (_34:`Item` {`name`:"Outlaw all abortions"})
create (_35:`Item` {`name`:"Expand availability of abortions"})
create (_36:`Item` {`name`:"Restrict access to abortions"})
create (_37:`Item` {`name`:"Maintain access to abortions"})
create (_38:`Item` {`name`:"Reduce unintended pregnancies"})
create (_39:`Item` {`name`:"Overturn Roe v. Wade"})
create (_40:`Item` {`name`:"Ensure access to affordable contraception"})
create (_41:`Item` {`name`:"Enact state-level restrictions to abortions"})
create (_42:`Item` {`name`:"Eliminate federal funding to abortion-related organizations"})
create (_43:`Item` {`name`:"Assert federal authority to assure access to abortions"})
create (_44:`Item` {`name`:"Fund Birth Control Education Programs"})
create (_45:`Item` {`name`:"Maintain Roe v. Wade"})
create (_46:`Item` {`name`:"Repeal state-level restrictions to abortions"})
create (_47:`Person` {`name`:"Test 1"})
create (_48:`Person` {`name`:"Test 1"})
create (_49:`Person` {`name`:"Test 2"})
create (_50:`Community` {`name`:"Test 3"})
create (_51:`Community` {`name`:"Test 4"})
create (_54:`Person` {`name`:"Test User 1"})
create (_55:`Person` {`name`:"Test User 2"})
create (_56:`Person` {`name`:"Test User 3"})
create (_57:`Issue` {`name`:"Test Issue 1"})
create (_58:`Issue` {`name`:"Test Issue 2"})
create (_59:`Issue` {`name`:"Test Issue 3"})
create (_69:`Community` {`name`:"Demo 3"})
create (_70:`Community` {`name`:"Demo 4"})
create (_71:`Item` {`name`:"Test Value 1"})
create (_72:`Item` {`name`:"Test Objective 1"})
create (_73:`Item` {`name`:"Test Policy 1"})
create (_74:`Item` {`name`:"Test Policy 2"})
create (_75:`Item` {`name`:"Test Objective 2"})
create (_76:`Item` {`name`:"Test Value 2"})
create (_77:`Community` {`name`:"Test 5"})
create (_79:`Issue` {`name`:"Test Issue 4"})
create _0-[:`ISSUE`]->_1
create _0-[:`ISSUE`]->_2
create _0-[:`ISSUE`]->_3
create _0-[:`MEMBER`]->_47
create _0-[:`MEMBER`]->_49
create _1-[:`VALUE`]->_4
create _1-[:`VALUE`]->_5
create _1-[:`VALUE`]->_6
create _1-[:`VALUE`]->_7
create _1-[:`VALUE`]->_8
create _1-[:`OBJECTIVE`]->_9
create _1-[:`OBJECTIVE`]->_10
create _1-[:`OBJECTIVE`]->_11
create _1-[:`OBJECTIVE`]->_12
create _1-[:`OBJECTIVE`]->_13
create _1-[:`POLICY`]->_14
create _1-[:`POLICY`]->_15
create _1-[:`POLICY`]->_16
create _1-[:`POLICY`]->_17
create _1-[:`POLICY`]->_18
create _1-[:`POLICY`]->_19
create _1-[:`POLICY`]->_20
create _1-[:`POLICY`]->_21
create _22-[:`ISSUE`]->_23
create _22-[:`ISSUE`]->_24
create _22-[:`ISSUE`]->_25
create _22-[:`MEMBER`]->_48
create _22-[:`MEMBER`]->_49
create _23-[:`SUBSET`]->_26
create _23-[:`SUBSET`]->_27
create _23-[:`SUBSET`]->_28
create _26-[:`ITEM`]->_29
create _26-[:`ITEM`]->_30
create _26-[:`ITEM`]->_31
create _26-[:`ITEM`]->_32
create _26-[:`ITEM`]->_33
create _27-[:`ITEM`]->_34
create _27-[:`ITEM`]->_35
create _27-[:`ITEM`]->_36
create _27-[:`ITEM`]->_37
create _27-[:`ITEM`]->_38
create _28-[:`ITEM`]->_39
create _28-[:`ITEM`]->_40
create _28-[:`ITEM`]->_41
create _28-[:`ITEM`]->_42
create _28-[:`ITEM`]->_43
create _28-[:`ITEM`]->_44
create _28-[:`ITEM`]->_45
create _28-[:`ITEM`]->_46
create _47-[:`RANK` {`value`:4.000000}]->_4
create _47-[:`RANK` {`value`:4.000000}]->_5
create _47-[:`RANK` {`value`:4.000000}]->_6
create _47-[:`RANK` {`value`:4.000000}]->_7
create _47-[:`RANK` {`value`:4.000000}]->_8
create _47-[:`RANK` {`value`:3.000000}]->_9
create _47-[:`RANK` {`value`:3.000000}]->_10
create _47-[:`RANK` {`value`:4.000000}]->_11
create _47-[:`RANK` {`value`:4.000000}]->_12
create _47-[:`RANK` {`value`:4.000000}]->_13
create _47-[:`RANK` {`value`:5.000000}]->_14
create _47-[:`RANK` {`value`:2.000000}]->_15
create _47-[:`RANK` {`value`:5.000000}]->_16
create _47-[:`RANK` {`value`:2.000000}]->_17
create _47-[:`RANK` {`value`:2.000000}]->_18
create _47-[:`RANK` {`value`:3.000000}]->_19
create _47-[:`RANK` {`value`:4.000000}]->_20
create _47-[:`RANK` {`value`:1.000000}]->_21
create _50-[:`ISSUE`]->_58
create _50-[:`ISSUE`]->_57
create _50-[:`MEMBER`]->_55
create _50-[:`MEMBER`]->_54
create _51-[:`ISSUE`]->_59
create _51-[:`ISSUE`]->_57
create _51-[:`MEMBER`]->_56
create _51-[:`MEMBER`]->_54
create _54-[:`RANK` {`value`:1.000000}]->_74
create _54-[:`RANK` {`value`:1.000000}]->_72
create _54-[:`RANK` {`value`:3.000000}]->_73
create _54-[:`RANK` {`value`:1.000000}]->_75
create _54-[:`RANK` {`value`:5.000000}]->_71
create _55-[:`RANK` {`value`:4.000000}]->_74
create _55-[:`RANK` {`value`:3.000000}]->_72
create _55-[:`RANK` {`value`:4.000000}]->_73
create _55-[:`RANK` {`value`:2.000000}]->_75
create _55-[:`RANK` {`value`:4.000000}]->_71
create _57-[:`VALUE`]->_71
create _57-[:`OBJECTIVE`]->_72
create _57-[:`POLICY`]->_74
create _58-[:`VALUE`]->_71
create _58-[:`OBJECTIVE`]->_75
create _58-[:`POLICY`]->_73
create _59-[:`VALUE`]->_76
create _59-[:`OBJECTIVE`]->_72
create _59-[:`POLICY`]->_73
create _77-[:`ISSUE`]->_79
create _77-[:`ISSUE`]->_58
create _77-[:`MEMBER`]->_55
create _79-[:`POLICY`]->_74
;
commit

