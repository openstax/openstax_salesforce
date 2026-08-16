## 8.4.0

* Default to the OAuth client credentials flow. Salesforce retires the
  username-password flow in Spring '27 (enforced Feb 20, 2027).
* Apps that still set `username`/`password`/`security_token` keep the old flow, so
  each one can migrate on its own schedule.
* Client credentials requires the org's My Domain as the `login_domain`;
  `validate!` now rejects `login.salesforce.com` and `test.salesforce.com`.

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
