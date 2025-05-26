use('test')// 기본 데이터 베이스, test 사용함. 생랷히 기본 test 데이터베이스 사용

// 테이블 설정,
// 테이블 생성 후, 데이터 추가하는 기본 문법 : insertOne
//SQL 사용하는 테이블, NOSQL 컬렉션으로 사용함.
// db.[테이블명].insertOne({
//    [컬럼명]:[값],
//    name: "홍길동",
//    age: 20,
//    favorite: ['apple', 'banana',],
// })

// 한줄 실행 : crtl + alt + s
// 전체 실행 : crtl + alt + r
// 하나 입력

db.users.insertOne({
    name: "홍길동",
    age: 20,
    favorite: ['apple', 'banana'],
})

// 조회
// db.[테이블명].find({조건})
db.users.find();

// 수정
// db.[테이블명].updateOne({조건}, {수정할 값})
db.users.updateOne(
    { name: "홍길동" }, // 조건
    { $set: { age: 30 } } // 수정할 값
)

// 삭제
// db.[테이블명].deleteOne({조건})
db.users.deleteOne({ name: "홍길동" }) // 조건에 맞는 첫 번째 문서 삭제



// Capped collection, 컬렉션 = 테이블
// 컬렉션이 용량 초과하게 되면, 오래된 데이터 부터 차례대로 삭제하는 기능.
// db.createCollection(컬렉션명, {capped: true, size: [용량]})
// 용량이 5KB인 컬렉션 생성, 부가 기능으로 용량 초과시 오래된 데이터 삭제
db.createCollection("logs", { capped: true, size: 5000 }) // 5KB
// 샘플 데이터 추가, 반복문을 이용해서 , 샘플로 1000개 추가
for (let i = 2000; i < 3000; i++) {
    db.logs.insertOne({
        message: `로그 메세지 ${i}`,
        timestamp: new Date() // 오라클로 표현
    })
}
db.logs.find() // 전체 조회.

db.createCollection("logs2", { capped: true, size: 5000 }) // 5KB
for (let i = 1000; i < 2000; i++) {
    db.logs2.insertOne({
        message: `로그 메세지 ${i}`,
        timestamp: new Date() // 오라클로 표현 sysdate() 같음, 현재 날짜
    })
}

db.createCollection("logs3", { capped: true, size: 5000 }) // 5KB3
for (let i = 1000; i < 2000; i++) {
    db.logs3.insertOne({
        message: `로그 메세지 ${i}`,
        timestamp: new Date() // 오라클로 표현 sysdate() 같음, 현재 날짜
    })
}

db.createCollection("logs4", { capped: true, size: 5000 })
for (let i = 1; i < 1000; i++) {
    db.logs4.insertOne({
        message: `로그 메세지 ${i}`,
        // 로그메세지 감싸는 기호는 백틱(`) 사용
        // 백틱은 키보드에서 숫자 1 왼쪽에 있는 기호
        timestamp: new Date()
    })
}

db.users2.find()
// 퀴즈 1, 한개 문서 삽입, 컬렉션 명 : users2
// 이름, 생년월일, 좋아하는 음식, 등록날짜
db.createCollection("users2", { capped: true, size: 5000 }) // 5KB

// db.users2.insertOne({
//     name: "정찬우",
//     birth: { year: 1997, month: 10, day: 27 },
//     registered: { year: 2025, month: 05, day: 23 }
// })

db.users2.insertOne({
    name: "정찬우",
    birth: '1997-10-27',
    favorite: ['돼지국밥', '김치찌개'],
    registered: new Date() // 오라클로 표현 sysdate() 같음, 현재 날짜    
})




// 퀴즈 2, 컬렉션 명 : users2, 수정해보기,
// 학목들 중, 수정2 문자열 추가해보기.
db.users2.updateOne(
    { name: "정찬우" }, // 조건
    { $set: { name: "정찬우 수정2" } } // 수정할 값
)



// 퀴즈 3, users2에서, 등록한 항목 삭제해보기.
db.users2.deleteOne({ name: "정찬우 수정2" }) // 조건에 맞는 첫 번째 문서 삭제  