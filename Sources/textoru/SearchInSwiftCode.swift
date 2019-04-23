//
//  SearchInSwiftCode.swift
//  textoru
//
//  Created by yuka ezura on 2019/04/20.
//

import Foundation
import SwiftSyntax
import Files

enum StringSyntaxFamily {
    case stringLiteralSyntax(StringLiteralExprSyntax)
    case stringInterpolationExprSyntax(StringInterpolationExprSyntax)
    
    var text: String {
        switch self {
        case .stringLiteralSyntax(let syntax):
            return String(syntax.stringLiteral.withoutTrivia().text
                .replacingOccurrences(
                    of: #"(^"+|"+$)"#,
                    with: "",
                    options: .regularExpression
                ))
        case .stringInterpolationExprSyntax(let syntax):
            return syntax.segments.map {
                $0.description
                }.joined()
        }
    }
    
    var position: AbsolutePosition {
        switch self {
        case .stringLiteralSyntax(let syntax as Syntax),
             .stringInterpolationExprSyntax(let syntax as Syntax):
            return syntax.position
        }
    }
}

class TextVisitor: SyntaxVisitor {
    typealias OnFoundBlock = (StringSyntaxFamily) -> Void
    let onFound: OnFoundBlock
    
    init(onFound: @escaping OnFoundBlock) {
        self.onFound = onFound
    }
    
    override func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
        onFound(.stringLiteralSyntax(node))
        return .skipChildren
    }
    
    override func visit(_ node: StringInterpolationExprSyntax) -> SyntaxVisitorContinueKind {
        onFound(.stringInterpolationExprSyntax(node))
        return .skipChildren
    }
}

class TextFounder {
    var texts: [StringSyntaxFamily] = []
    
    func run(file: File) -> [FoundText] {
        let fileURL = URL(fileURLWithPath: file.path)
        let syntaxTree = try! SyntaxTreeParser.parse(fileURL)
        
        let textVisitor = TextVisitor { [unowned self] (syntax) in
            self.texts.append(syntax)
        }
        syntaxTree.walk(textVisitor)
        
        return texts.map {
            FoundText(filename: file.name,
                      position: "\($0.position.line):\($0.position.column)",
                      text: $0.text)
        }
    }
}
