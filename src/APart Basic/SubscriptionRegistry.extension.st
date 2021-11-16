Extension { #name : #SubscriptionRegistry }

{ #category : #'*APart Basic' }
SubscriptionRegistry >> hasSubscriptionsOf: anObject for: anAnnouncementClass [
	| copy |
	self protected: [ copy := subscriptions copy ].
	^ copy
		anySatisfy: [ :subscription | 
			subscription subscriber == anObject
				and: [ subscription announcementClass = anAnnouncementClass ] ]
]
