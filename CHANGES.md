## 10.0.0

* `Lead` gains `is_converted` (`IsConverted`) and `converted_contact_id`
  (`ConvertedContactId`). Salesforce converts Account Creation leads into an
  existing Contact when one matches by email or UUID, and this org allows updates
  to converted leads, so a caller re-saving a stale lead id was writing onto a
  converted lead instead of the Contact. Callers can now follow the conversion.
* `Contact` gains the signup-profile fields a caller needs to finish that write on
  the Contact: `phone`, `title`, `role`, `position`, `who_chooses_books`,
  `subject_interest`, `expected_start_semester`, `adoption_json`, `num_students`,
  `os_accounts_id`, `tracking_parameters` and `newsletter_opt_in`. Attribute names
  match `Lead`'s so the same assignment code serves both. `FV_Status__c` stays
  read-only in spirit: once a Contact exists that field is owned by Customer
  Experience. `newsletter_opt_in` maps to `Newsletter_Opt_In__c`, which is the one
  newsletter field going forward; `Newsletter_Opt_Out__c` is being retired and is
  deliberately not mapped.
* **Breaking:** removed five `Lead` fields. `b_r_i_marketing` (`BRI_Marketing__c`),
  `title_1_school` (`Title_1_school__c`), `instant_conversion`
  (`Instant_Conversion__c`) and `subject` (`Subject__c`) were dead: across ~16k
  Account Creation leads in the 180 days to 2026-09-05 none had any of them set,
  and no flow, formula, validation rule or list view in the org references them.
  `newsletter` (`Newsletter__c`) duplicated `newsletter_opt_in`
  (`Newsletter_Opt_In__c`), which is the one Salesforce automation reads; one
  newsletter field is enough. `subject_interest` (`Subject_Interest__c`) is the
  subject field in use.

## 9.0.0

* Default to the OAuth client credentials flow. Salesforce retires the
  username-password flow in Spring '27 (enforced Feb 20, 2027).
* Setting `username`/`password`/`security_token` still selects the old flow, to keep
  the cutover reversible.
* Client credentials requires the org's My Domain as the `login_domain`;
  `validate!` now rejects `login.salesforce.com` and `test.salesforce.com`.
* `validate!` also rejects a `password`/`security_token` left set without a `username`,
  so a half-removed config fails loudly instead of silently switching flows.
* **Breaking:** requires Ruby >= 3.0, Rails >= 6.1 and Restforce >= 7.1. Restforce
  only gained the client credentials middleware in 7.1, and that line of Restforce
  dropped Ruby 2.7 — so the old flow is the only one that ever worked on Ruby 2.7.
  Stay on 8.3.0 there.
* No longer caps `rails < 7.0`. Note `openstax_active_force` still does, so that gem
  has to move before an app can actually reach Rails 7.

(Entries below predate a long gap in this file.)

## 1.2.0

* Added `first_arrived_my_courses_at` field to `CampaignMember`

## 1.1.0

* https://github.com/openstax/openstax_salesforce/pull/10
* Added `Campaign` without many fields
* Fixes for relations between CampaignMember and Campaign (minor version bump because these were not used yet)
* Spec proxy helper additions for Campaign and CampaignMember

## 1.0.0

* Added `CampaignMember`, untested
* Added `application_source` to `Lead`
* Changed `Lead`'s `accounts_uuid` field to match what is in SF (`accounts_uuid_c__c`) - this is probably a typo in SF, but it is what is there now.
