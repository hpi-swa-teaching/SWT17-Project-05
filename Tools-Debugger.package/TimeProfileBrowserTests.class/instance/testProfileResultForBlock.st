as yet unclassified
testProfileResultForBlock

	| profilerResult profilerResultMorph profilerResultMorphWrapper|

	"TODO: change this next line to not use a 2nd process!?"
	[profilerResult := self testProfileBlock] newProcess resume.
	(Delay forMilliseconds: 5000) wait.
	profilerResultMorph := (profilerResult dependents select: [:instance | instance isKindOf: PluggableSystemWindow]) first.
	profilerResultMorphWrapper := MTFMorphWrapper newWith: {profilerResultMorph}.
	self assert: (profilerResultMorphWrapper findByCriteria: [:morph | (morph isKindOf: IndentingListItemMorph) and: [morph getLabel = 'Process: other processes']]) morphs size == 1.
	self assert: (profilerResultMorphWrapper findByCriteria: [:morph | (morph isKindOf: IndentingListItemMorph) and: [morph getLabel =  'No tallies obtained']]) morphs size == 0.