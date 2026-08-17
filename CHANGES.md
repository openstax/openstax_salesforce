## 9.0.0

* Default to the OAuth client credentials flow. Salesforce retires the
  username-password flow in Spring '27 (enforced Feb 20, 2027).
* Setting `username`/`password`/`security_token` still selects the old flow, to keep
  the cutover reversible.
* Client credentials requires the org's My Domain as the `login_domain`;
  `validate!` now rejects `login.salesforce.com` and `test.salesforce.com`.
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
