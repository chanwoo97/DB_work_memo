use('test')

db.test.insertOne({
    name: "홍길동",
    age: 20,
    favorite: ['apple', 'banana'],
})

db.createCollection("logs", { capped: true, size: 5000 })

for (let i = 1000; i < 3000; i++) {
    db.logs.insertOne({
        message: `로그 메세지 ${i}`,
        timestamp: new Date()
    })
}

db.users.find()

db.users.insertOne({
    이름 : "정찬우1",
    생년월일 : "1997-10-27",
    좋아하는음식 : "볶음밥",
    등록날짜 : new Date()
})

db.users.insertOne({
    이름 : "정찬우2",
    생년월일 : "1997-10-27",
    좋아하는음식 : "볶음밥",
    등록날짜 : new Date()
})

db.users.insertOne({
    이름 : "정찬우3",
    생년월일 : "1997-10-27",
    좋아하는음식 : "볶음밥",
    등록날짜 : new Date()
})



db.users.updateOne(
    { 이름 : "정찬우1" },
    { $set: {좋아하는음식 : "돼지국밥"} }
)

db.users.deleteOne({ 이름 : "정찬우3" })