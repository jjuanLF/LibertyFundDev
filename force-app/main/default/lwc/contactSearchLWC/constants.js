const personTypeOptions = () => {
    return [
        { value: '', label: '' },
        { value: 'Academic', label: 'Academic' },
        { value: 'Professional', label: 'Professional' },
        { value: 'Student', label: 'Student' },
        { value: 'LF', label: 'Liberty Fund' },
        { value: 'Unassigned', label: 'Unassigned' }
    ];
};

const primaryExpertiseOptions = () => {
    return [
        { value: '', label: '' },
        { value: 'Anthropology', label: 'Anthropology' },
        { value: 'BioEthics', label: 'BioEthics' },
        { value: 'Business', label: 'Business' },
        { value: 'Classics', label: 'Classics' },
        { value: 'Economics', label: 'Economics' },
        { value: 'Education', label: 'Education' },
        { value: 'Government', label: 'Government' },
        { value: 'History', label: 'History' },
        { value: 'Intl Relations', label: 'Intl Relations' },
        { value: 'Journalism/Media', label: 'Journalism/Media' },
        { value: 'Language', label: 'Language' },
        { value: 'Law', label: 'Law' },
        { value: 'Literature', label: 'Literature' },
        { value: 'Mathematics', label: 'Mathematics' },
        { value: 'Medical', label: 'Medical' },
        { value: 'Music/Art/Culture', label: 'Music/Art/Culture' },
        { value: 'Philosophy', label: 'Philosophy' },
        { value: 'Psychology', label: 'Psychology' },
        { value: 'Public Intellectual', label: 'Public Intellectual' },
        { value: 'Public Policy', label: 'Public Policy' },
        { value: 'Science', label: 'Science' },
        { value: 'Social/Pol Thought', label: 'Social/Pol Thought' },
        { value: 'Sociology', label: 'Sociology' },
        { value: 'Technology', label: 'Technology' },
        { value: 'Theology', label: 'Theology' }
    ];
};

const regionOptions = () => {
    return [
        { value: '', label: '' },
        { value: 'North America', label: 'North America' },
        { value: 'Latin America', label: 'Latin America' },
        { value: 'Europe', label: 'Europe' },
        { value: 'Africa', label: 'Africa' },
        { value: 'Middle East', label: 'Middle East' },
        { value: 'Australia', label: 'Australia' },
        { value: 'Asia', label: 'Asia' }
    ];
};

const columns = () => {
    return [
        {
            label: 'C/L',
            fieldName: 'resultIndicator',
            type: 'button-icon',
            typeAttributes: { 
                iconName: {fieldName: 'typeIndicator'},
                alternativeText: {fieldName: 'typeTitle'},
                title: {fieldName: 'typeTitle'},
                //iconClass: {},
                variant: 'bare',
                class: 'text-button'
                //disabled: true
            },
            hideDefaultActions: true,
            cellAttributes: { alignment: 'center' }
        },
        {
            label: 'Name',
            fieldName: 'recordURL',
            type: 'url',
            typeAttributes: {
                label: { fieldName: 'recordName', target: '_blank' }
            },
            sortable: true
        },
        {
            label: 'Affiliation',
            fieldName: 'primaryAffiliation',
            sortable: true
        },
        {
            label: 'Primary Expertise',
            fieldName: 'primaryExpertise',
            sortable: true
        },
        {
            label: 'Most Recent Attended',
            fieldName: 'mostRecentAttendedDate',
            type: 'date',
            sortable: true,
            cellAttributes: { alignment: 'center' }
        },
        {
            label: 'Core Future',
            fieldName: 'attendedFuture',
            type: 'number',
            sortable: true,
            hideDefaultActions: true,
            cellAttributes: { alignment: 'center' }
        },
        {
            label: '#Past 12 Months',
            fieldName: 'attendedRecent',
            type: 'number',
            sortable: true,
            hideDefaultActions: true,
            cellAttributes: { alignment: 'center' }
        },
        {
            label: 'Core Total',
            fieldName: 'attendedConfTotal',
            type: 'number',
            sortable: true,
            hideDefaultActions: true,
            cellAttributes: { alignment: 'center' }
        },
        {
            label: '#Dir',
            fieldName: 'countDirector',
            type: 'number',
            sortable: true,
            hideDefaultActions: true,
            cellAttributes: { alignment: 'center' }
        },
        {
            label: '#DL',
            fieldName: 'countDiscLead',
            type: 'number',
            sortable: true,
            hideDefaultActions: true,
            cellAttributes: { alignment: 'center' }
        },
        {
            label: 'Exceptional',
            fieldName: 'expAboveExp',
            type: 'button-icon',
            typeAttributes: { 
                iconName: {fieldName: 'expAboveExp'},
                alternativeText: 'Exceptional or Above Expectations',
                title: 'Exceptional or Above Expectations',
                //iconClass: {},
                variant: 'bare',
                class: 'text-button'
                //disabled: true
            },
            hideDefaultActions: true,
            cellAttributes: { alignment: 'center' }
        },
        {
            label: 'Promising',
            fieldName: 'expPromising',
            type: 'button-icon',
            typeAttributes: { 
                iconName: {fieldName: 'expPromising'},
                alternativeText: 'Promising',
                title: 'Promising',
                //iconClass: {},
                variant: 'bare',
                class: 'text-button'
                //disabled: true
            },
            hideDefaultActions: true,
            cellAttributes: { alignment: 'center' }
        },
        {
            label: 'Inactive',
            fieldName: 'isInactive',
            type: 'button-icon',
            typeAttributes: { 
                iconName: {fieldName: 'isInactive'},
                alternativeText: 'Inactive',
                title: 'Inactive',
                //iconClass: {},
                variant: 'bare',
                class: 'text-button'
                //disabled: true
            },
            hideDefaultActions: true,
            cellAttributes: { alignment: 'center' }
        },
        {
            label: 'Deceased',
            fieldName: 'isDeceased',
            type: 'button-icon',
            typeAttributes: { 
                iconName: {fieldName: 'isDeceased'},
                alternativeText: 'Deceased',
                title: 'Deceased',
                //iconClass: 'red-icon',
                variant: 'bare',
                class: 'text-button'
                //disabled: true
            },
            hideDefaultActions: true,
            cellAttributes: { alignment: 'center' }
        },
        {
            label: 'TMap',
            fieldName: 'hasTMap',
            type: 'button-icon',
            typeAttributes: { 
                iconName: {fieldName: 'hasTMap'},
                alternativeText: 'TMap',
                title: 'TMap',
                //iconClass: {},
                variant: 'bare',
                class: 'text-button'
                //disabled: true
            },
            hideDefaultActions: true,
            cellAttributes: { alignment: 'center' }
        }
        // {label: 'Id', fieldName: 'recordId'}, //Used to create Name url to record
        // {label: 'Indicators', fieldName: 'evaluationImage'},
        // {label: 'TMap', fieldName: 'tMapImage'},
        // {label: 'City', fieldName: 'mailingCity'}, //Not used in table
        // {label: 'State', fieldName: 'mailingState'}, //Not used in table
        // {label: 'Country', fieldName: 'mailingCountry'}, //Not used in table
        // {label: 'Total', fieldName: 'attendedTotal', type: 'number'}, //Not used in table
        // {label: 'Co-Spo Total', fieldName: 'attendedCoSponTotal', type: 'number'} //Not used in table
    ];
};

export { personTypeOptions, primaryExpertiseOptions, regionOptions, columns };