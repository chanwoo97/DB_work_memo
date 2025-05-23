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