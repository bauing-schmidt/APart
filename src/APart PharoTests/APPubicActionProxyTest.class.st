Class {
	#name : #APPubicActionProxyTest,
	#superclass : #TestCase,
	#category : #'APart PharoTests'
}

{ #category : #tests }
APPubicActionProxyTest >> testCreation [

	| action proxy executed |
	
	executed := false. 
	
	action := APPublicAction key: #someAction do: [ executed := true ] if: APCondition true. 
	proxy := 	APPublicActionProxy from: action.
		
	self assert: proxy targetAction equals: action.
	self deny: executed
	

]
