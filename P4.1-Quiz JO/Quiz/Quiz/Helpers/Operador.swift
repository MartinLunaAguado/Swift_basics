//
//  Operador.swift
//  Quiz
//
//  Created by c104 DIT UPM on 27/11/23.
//
import Foundation


// Compara si la respuesta introducida es "más o menos" la respuesta correcta


infix operator =+-=: ComparisonPrecedence

extension String {
    static func =+-=(s1: String, s2: String) -> Bool {
        let a =  s1.lowercased().trimmingCharacters(in: .whitespaces)
        let b =  s2.lowercased().trimmingCharacters(in: .whitespaces)
        return a == b
    }
}
		
