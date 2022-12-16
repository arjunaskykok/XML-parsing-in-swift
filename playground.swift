import Foundation


let xmlContent =
"""
<?xml version="1.0" encoding="UTF-8"?>
<root>
    <article>
        <title>Getting Started with Swift</title>
    </article>
    <article>
        <title>How to Parse XML with Rust</title>
    </article>
</root>
""";

let xmlData = Data(xmlContent.utf8)
let xmlParser = XMLParser(data: xmlData)

class Parser1 : NSObject, XMLParserDelegate {
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("Start of the document")
        print("Line number: \(parser.lineNumber)")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("End of the document")
        print("Line number: \(parser.lineNumber)")
    }
    
}
let parser1 = Parser1()
xmlParser.delegate = parser1

xmlParser.parse()

class Parser2 : NSObject, XMLParserDelegate {
    
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        print(elementName)
    }
    
}

let parser2 = Parser2()
let xmlParser2 = XMLParser(data: xmlData)
xmlParser2.delegate = parser2

xmlParser2.parse()

class Parser3 : NSObject, XMLParserDelegate {
    
    var articleNth = 0
    
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        if (elementName=="article") {
            articleNth += 1
        } else if (elementName=="title") {
            print("'\(elementName)' in the article number \(articleNth)")
        }
    }
    
}

let parser3 = Parser3()
let xmlParser3 = XMLParser(data: xmlData)
xmlParser3.delegate = parser3

xmlParser3.parse()

let xmlContent_attributes =
"""
<?xml version="1.0" encoding="UTF-8"?>
<root>
    <article id="1" tag="swift">
        <title>Getting Started with Swift</title>
    </article>
    <article id="2" tag="rust">
        <title>How to Parse XML with Rust</title>
    </article>
</root>
""";
let xmlData_attributes = Data(xmlContent_attributes.utf8)

class Parser4 : NSObject, XMLParserDelegate {
    
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        for (attr_key, attr_val) in attributeDict {
            print("Key: \(attr_key), value: \(attr_val)")
        }
    }
    
}

let parser4 = Parser4()
let xmlParser4 = XMLParser(data: xmlData_attributes)
xmlParser4.delegate = parser4

xmlParser4.parse()

let xmlContent_namespace =
"""
<?xml version="1.0" encoding="UTF-8"?>
<root xmlns:t="http://logrocket.com/tech" xmlns:m="http://logrocket.com/marketing">
    <t:article>
        <t:title>Getting Started with Swift</t:title>
    </t:article>
    <m:article>
        <m:title>How to Parse XML with Rust</m:title>
    </m:article>
</root>
""";

let xmlData_namespace = Data(xmlContent_namespace.utf8)

class Parser5 : NSObject, XMLParserDelegate {
    
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        print("Namespace URI: \(namespaceURI!), qualified name: \(qName!)")
    }
    
}

let parser5 = Parser5()
let xmlParser5 = XMLParser(data: xmlData_namespace)
xmlParser5.delegate = parser5
xmlParser5.shouldProcessNamespaces = true

xmlParser5.parse()

let xmlContent_text =
"""
<?xml version="1.0" encoding="UTF-8"?>
<root>
    <article>
        <title>Getting Started with Swift</title>
        <published>true</published>
    </article>
    <article>
        <title>How to Parse XML with Rust</title>
        <published>false</published>
    </article>
</root>
""";
let xmlData_text = Data(xmlContent_text.utf8)

class Parser6 : NSObject, XMLParserDelegate {
    
    func parser(
        _ parser: XMLParser,
        foundCharacters string: String
    ) {
        if (string.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
            print(string)
        }
    }
    
}

let parser6 = Parser6()
let xmlParser6 = XMLParser(data: xmlData_text)
xmlParser6.delegate = parser6

xmlParser6.parse()

let xmlContent_corrupted =
"""
<?xml version="1.0" encoding="UTF-8"?>
<root>
    <article>
        <title>Getting Started with Swift</title>
    </article>
    <article>
        <title>How to Parse XML with Rust
    </article>
</root>
""";
let xmlData_corrupted = Data(xmlContent_corrupted.utf8)

class Parser7 : NSObject, XMLParserDelegate {
    
    func parser(
        _ parser: XMLParser,
        parseErrorOccurred parseError: Error
    ) {
        print(parseError)
    }
    
}

let parser7 = Parser7()
let xmlParser7 = XMLParser(data: xmlData_corrupted)
xmlParser7.delegate = parser7

xmlParser7.parse()
