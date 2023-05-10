//
//  QuestionCardView.swift
//  Hyoza
//
//  Created by HAN GIBAEK on 2023/05/09.
//

import SwiftUI

struct QuestionCardView: View {
    @Binding var openDegree: Double
    @Binding var closedDegree: Double
    @Binding var question1Difficulty: String
    @Binding var question2Difficulty: String
    @Binding var question3Difficulty: String
    @Binding var easyQuestions: [QuerySentence]
    @Binding var hardQuestions: [QuerySentence]
    
    var body: some View {
        ZStack {
            OpenCardView(degree: $openDegree)
                .onTapGesture {
                    withAnimation(.linear(duration: 0.3)) {
                        openDegree = -90
                    }
                    withAnimation(.linear(duration: 0.3).delay(0.3)){
                        closedDegree = 0
                    }
                }
            ClosedCardListView(degree: $closedDegree, question1Difficulty: $question1Difficulty, question2Difficulty: $question2Difficulty, question3Difficulty: $question3Difficulty, easyQuestions: $easyQuestions, hardQuestions: $hardQuestions)
                .onTapGesture {
                    withAnimation(.linear(duration: 0.3)) {
                        closedDegree = 90
                    }
                    withAnimation(.linear(duration: 0.3).delay(0.3)){
                        openDegree = 0
                    }
                }
        }
    }
}

struct ClosedCardView: View {
    let difficulty: String
    let questionNumber: Int
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                CapsuleView(content: {
                    Text(difficulty)
                        .font(.footnote)
                        .foregroundColor(.textOrange)
                        .padding([.leading, .trailing], 12)
                        .padding([.top, .bottom], 4)
                }, capsuleColor: .backGroundLightOrange)
                Spacer()
            }
            Spacer()
            Text("Q\(questionNumber)")
                .font(.title)
            Spacer()
            Text("")
            Spacer()
        }
    }
    
    init(difficulty: QuestionDifficulty, questionNumber: Int) {
        if difficulty == .easy {
            self.difficulty = "쉬움"
        } else {
            self.difficulty = "어려움"
        }
        self.questionNumber = questionNumber
    }
    
    
}

struct ClosedCardListView: View {
    @Binding var degree: Double
    @Binding var question1Difficulty: String
    @Binding var question2Difficulty: String
    @Binding var question3Difficulty: String
    @Binding var easyQuestions: [QuerySentence]
    @Binding var hardQuestions: [QuerySentence]
    
//    var easyQuestion1 = QuerySentenceManager.shared.filtered(difficulty: .easy)[0]
//    var easyQuestion2 = QuerySentenceManager.shared.filtered(difficulty: .easy)[0]
//    var hardQuestion = QuerySentenceManager.shared.filtered(difficulty: .hard)[0]
    
    var body: some View {
        ZStack{
            Color.backGroundWhite
            VStack(spacing: 20) {
                Text("오늘의 질문을 고르세요")
                    .font(.title)
                CardView(backgroundColor: .cardLightOrange, cornerRadius: 15, shadowColor: .black.opacity(0.1), shadowRadius: 8){
                    ClosedCardView(difficulty: easyQuestions[0].difficulty, questionNumber: 1)
                }
                CardView(backgroundColor: .cardLightOrange, cornerRadius: 15, shadowColor: .black.opacity(0.1), shadowRadius: 8){
                    ClosedCardView(difficulty: hardQuestions[0].difficulty, questionNumber: 2)
                }
                CardView(backgroundColor: .cardLightOrange, cornerRadius: 15, shadowColor: .black.opacity(0.1), shadowRadius: 8){
                    ClosedCardView(difficulty: easyQuestions[0].difficulty, questionNumber: 3)
                }
            }
            .padding(20)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (0, 1, 0))
    }
}

struct OpenCardView: View {
    @Binding var degree: Double
    let difficulty: String = "쉬움"
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.backGroundWhite
                VStack{
                    HStack {
                        CapsuleView(content: {
                            Text(difficulty)
                                .font(.footnote)
                                .foregroundColor(.textOrange)
                                .padding([.leading, .trailing], 12)
                                .padding([.top, .bottom], 4)
                        }, capsuleColor: .backGroundLightOrange)
                        Spacer()
                        Text("2023년 5월 5일")
                            .font(.footnote)
                            .foregroundColor(.tapBarDarkGray)
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.textOrange)
                    }
                    Spacer()
                    Text("최근에 가장 재미있게 본 유튜브 영상은 무엇인가요?")
                        .font(.title)
                        .foregroundColor(.textBlack)
                        .bold()
                    Spacer()
                    CapsuleView(content: {
                        Text("열어보기")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.textWhite)
                            .padding([.top, .bottom], 20)
                            .frame(width: geo.size.width)
                    }, capsuleColor: .backGroundOrange)
                }
            }
            .rotation3DEffect(Angle(degrees: degree), axis: (0, 1, 0))
        }
    }
}

struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCardView(openDegree: .constant(-90), closedDegree: .constant(0), question1Difficulty: .constant("쉬움"), question2Difficulty: .constant("어려움"), question3Difficulty: .constant("쉬움"), easyQuestions: .constant([QuerySentence(id: 1, question: "최근에 재미있게 본 유튜브 채널에 대해 말해주세요~", difficulty: .easy), QuerySentence(id: 2, question: "강아지가 좋나요, 고양이가 좋나요?", difficulty: .easy)]), hardQuestions: .constant([QuerySentence(id: 3, question: "인생에서 가장 중요시하는 가치가 무엇이신가요?", difficulty: .hard), QuerySentence(id: 4, question: "부모님에게 '부모님'이란 어떤 존재였나요?", difficulty: .hard)]))
    }
}
