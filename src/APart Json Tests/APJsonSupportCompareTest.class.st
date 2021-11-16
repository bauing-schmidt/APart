Class {
	#name : #APJsonSupportCompareTest,
	#superclass : #TestCase,
	#category : #'APart Json Tests'
}

{ #category : #'running-helpers' }
APJsonSupportCompareTest >> jsonStringForTest01 [
	^'{
	"PdmSystemConfig": [
		{	"name": "Icon Base",
			"params": {
				"RasterIconBaseType": "PdmDefaultRasterIcons"
			}
		},
		{	"name": "Application",
			"params": {
				"SubappBuilderType": "PdmSubappConfigTypeExplorer",
				"ActiveSubappBuilderTypes": "PdmSubappConfigTypeExplorer,PdmSubappConfigTypeCalendar"
			}
		},
		{	"name": "Database",
			"params": {
			}
		}
	]
}'
]

{ #category : #running }
APJsonSupportCompareTest >> test01 [
	"Works only if #= and #hash are implemented correctly"
	
	| s obj1 obj2 |
	s := self jsonStringForTest01.
	obj1 := APJsonParser parse: s.
	obj2 := APJsonParser parse: s.
	self assert: obj1 equals: obj2
]
