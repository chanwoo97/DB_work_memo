-- copilot, GPT, ai 툴을 이용해서, 샘플 DB 설계(쇼핑몰 예시),
-- ERD 다이어그램 확인
-- 시퀀스 다이어그램 확인
-- DFD 다이어그램 확인

-- 샘플 디비 설계, 쇼핑몰을 예시로 해서 간단한 프롬포트 명령어 작성 해보기

-- 예시
-- 간단한 쇼핑몰 DB 설계를 할거야.
-- 생각한 테이블은 사용자, 게시글, 댓글, 상품, 장바구니, 주문, 결제, 배송
-- 중간테이블(장바구니에 담긴 상품), (주문된 상품)등도 고려해줘.
-- 혹시나 빠진 중간 테이블이 있다면, 추가도 해줘.
-- 설계한 코드는 DDL.sql 파일로 제공해주고,
-- create 코드 형식으로 코드 알려줘

-- 1차 견본 받은 후,
-- 누락된 부분, 또는 테스트나 검증등을 해서 수정될 가능성이 있음.

-- 검사 도구로, 다이어그램 등을 이용해서 그림으로 확인.
-- 아래 사이트에서, 그림 도식화 할 예정
-- https://www.gist.github.com/
-- .md 파일에, mermaid 라는 문법을 통해서, erd 그림을 그리기

-- 예시, 연속적으로 작업 하는 중이라서, 이미 코파일럿 메모리에 작성된 테이블이 있다는 가정하에
-- 만약, 연속 작업이 아니라고 한다면, 실제 테이블을 같이 복사를 하고 물어보기.
-- 현재는, 연속적인 상황이라서 이렇게만 질의하기.
-- 위에 작성된 ddl.sql 파일, create 테이블을 참고해서, mermaid 문법으로, erd 다이어그램 작성하는 코드 생성해줘


-- 제공 해준 테이블을 이용해서, 샘플 데이터를 추가하는 예시를 제공해줘
-- 각각의 모든 테이블을 검사 할수 있는 샘플 데이터 추가하는 예시코드
-- 추가하는 명령어, 조회 명령어도 같이 첨부해줘


--------------------------------------------------------------------------------------------------------------

-- 사용자 테이블
CREATE TABLE USERS (
    USER_ID      NUMBER PRIMARY KEY,
    USERNAME     VARCHAR2(50) UNIQUE NOT NULL,
    PASSWORD     VARCHAR2(100) NOT NULL,
    EMAIL        VARCHAR2(100) UNIQUE NOT NULL,
    PHONE        VARCHAR2(20),
    ADDRESS      VARCHAR2(200),
    CREATED_AT   DATE DEFAULT SYSDATE
);

-- 게시글 테이블
CREATE TABLE POSTS (
    POST_ID      NUMBER PRIMARY KEY,
    USER_ID      NUMBER REFERENCES USERS(USER_ID),
    TITLE        VARCHAR2(200) NOT NULL,
    CONTENT      CLOB,
    CREATED_AT   DATE DEFAULT SYSDATE
);

-- 댓글 테이블
CREATE TABLE COMMENTS (
    COMMENT_ID   NUMBER PRIMARY KEY,
    POST_ID      NUMBER REFERENCES POSTS(POST_ID),
    USER_ID      NUMBER REFERENCES USERS(USER_ID),
    CONTENT      VARCHAR2(500),
    CREATED_AT   DATE DEFAULT SYSDATE
);

-- 상품 테이블
CREATE TABLE PRODUCTS (
    PRODUCT_ID   NUMBER PRIMARY KEY,
    NAME         VARCHAR2(100) NOT NULL,
    DESCRIPTION  VARCHAR2(1000),
    PRICE        NUMBER(10,2) NOT NULL,
    STOCK        NUMBER DEFAULT 0,
    CREATED_AT   DATE DEFAULT SYSDATE
);

-- 장바구니 테이블
CREATE TABLE CARTS (
    CART_ID      NUMBER PRIMARY KEY,
    USER_ID      NUMBER REFERENCES USERS(USER_ID),
    CREATED_AT   DATE DEFAULT SYSDATE
);

-- 장바구니에 담긴 상품 (중간 테이블)
CREATE TABLE CART_ITEMS (
    CART_ITEM_ID NUMBER PRIMARY KEY,
    CART_ID      NUMBER REFERENCES CARTS(CART_ID),
    PRODUCT_ID   NUMBER REFERENCES PRODUCTS(PRODUCT_ID),
    QUANTITY     NUMBER DEFAULT 1
);

-- 주문 테이블
CREATE TABLE ORDERS (
    ORDER_ID     NUMBER PRIMARY KEY,
    USER_ID      NUMBER REFERENCES USERS(USER_ID),
    ORDER_DATE   DATE DEFAULT SYSDATE,
    STATUS       VARCHAR2(30) DEFAULT '주문접수'
);

-- 주문된 상품 (중간 테이블)
CREATE TABLE ORDER_ITEMS (
    ORDER_ITEM_ID NUMBER PRIMARY KEY,
    ORDER_ID      NUMBER REFERENCES ORDERS(ORDER_ID),
    PRODUCT_ID    NUMBER REFERENCES PRODUCTS(PRODUCT_ID),
    QUANTITY      NUMBER DEFAULT 1,
    PRICE         NUMBER(10,2) NOT NULL
);

-- 결제 테이블
CREATE TABLE PAYMENTS (
    PAYMENT_ID   NUMBER PRIMARY KEY,
    ORDER_ID     NUMBER REFERENCES ORDERS(ORDER_ID),
    PAYMENT_DATE DATE DEFAULT SYSDATE,
    AMOUNT       NUMBER(10,2) NOT NULL,
    METHOD       VARCHAR2(30),
    STATUS       VARCHAR2(30) DEFAULT '결제완료'
);

-- 배송 테이블
CREATE TABLE DELIVERIES (
    DELIVERY_ID  NUMBER PRIMARY KEY,
    ORDER_ID     NUMBER REFERENCES ORDERS(ORDER_ID),
    ADDRESS      VARCHAR2(200) NOT NULL,
    DELIVERY_DATE DATE,
    STATUS       VARCHAR2(30) DEFAULT '배송준비중'
);

-- (선택) 상품 이미지 테이블 (추가 중간 테이블 예시)
CREATE TABLE PRODUCT_IMAGES (
    IMAGE_ID     NUMBER PRIMARY KEY,
    PRODUCT_ID   NUMBER REFERENCES PRODUCTS(PRODUCT_ID),
    IMAGE_URL    VARCHAR2(300) NOT NULL
);


-- 샘플 데이터 추가 예시 및 조회 예시

-- USERS
INSERT INTO USERS VALUES (1, 'user1', 'pw1', 'user1@email.com', '010-1111-1111', '서울시 강남구', SYSDATE);
INSERT INTO USERS VALUES (2, 'user2', 'pw2', 'user2@email.com', '010-2222-2222', '부산시 해운대구', SYSDATE);

SELECT * FROM USERS;

-- PRODUCTS
INSERT INTO PRODUCTS VALUES (1, '노트북', '고성능 노트북', 1200000, 10, SYSDATE);
INSERT INTO PRODUCTS VALUES (2, '마우스', '무선 마우스', 25000, 100, SYSDATE);

SELECT * FROM PRODUCTS;

-- POSTS
INSERT INTO POSTS VALUES (1, 1, '첫 게시글', '내용1', SYSDATE);
INSERT INTO POSTS VALUES (2, 2, '두번째 게시글', '내용2', SYSDATE);

SELECT * FROM POSTS;

-- COMMENTS ```
INSERT INTO COMMENTS VALUES (1, 1, 2, '댓글1', SYSDATE);
INSERT INTO COMMENTS VALUES (2, 2, 1, '댓글2', SYSDATE);

SELECT * FROM COMMENTS;

-- CARTS
INSERT INTO CARTS VALUES (1, 1, SYSDATE);
INSERT INTO CARTS VALUES (2, 2, SYSDATE);

SELECT * FROM CARTS;

-- CART_ITEMS
INSERT INTO CART_ITEMS VALUES (1, 1, 1, 2); -- user1의 장바구니에 노트북 2개
INSERT INTO CART_ITEMS VALUES (2, 1, 2, 1); -- user1의 장바구니에 마우스 1개
INSERT INTO CART_ITEMS VALUES (3, 2, 2, 3); -- user2의 장바구니에 마우스 3개

SELECT * FROM CART_ITEMS;

-- ORDERS
INSERT INTO ORDERS VALUES (1, 1, SYSDATE, '주문접수');
INSERT INTO ORDERS VALUES (2, 2, SYSDATE, '주문접수');

SELECT * FROM ORDERS;

-- ORDER_ITEMS
INSERT INTO ORDER_ITEMS VALUES (1, 1, 1, 1, 1200000); -- user1 주문에 노트북 1개
INSERT INTO ORDER_ITEMS VALUES (2, 1, 2, 2, 25000);   -- user1 주문에 마우스 2개
INSERT INTO ORDER_ITEMS VALUES (3, 2, 2, 1, 25000);   -- user2 주문에 마우스 1개

SELECT * FROM ORDER_ITEMS;

-- PAYMENTS
INSERT INTO PAYMENTS VALUES (1, 1, SYSDATE, 1250000, '카드', '결제완료');
INSERT INTO PAYMENTS VALUES (2, 2, SYSDATE, 25000, '무통장입금', '결제완료');

SELECT * FROM PAYMENTS;

-- DELIVERIES
INSERT INTO DELIVERIES VALUES (1, 1, '서울시 강남구', SYSDATE, '배송중');
INSERT INTO DELIVERIES VALUES (2, 2, '부산시 해운대구', SYSDATE, '배송준비중');

SELECT * FROM DELIVERIES;

-- PRODUCT_IMAGES
INSERT INTO PRODUCT_IMAGES VALUES (1, 1, 'http://example.com/laptop.jpg');
INSERT INTO PRODUCT_IMAGES VALUES (2, 2, 'http://example.com/mouse.jpg');

SELECT * FROM PRODUCT_IMAGES;

----------------------------------------------------------------------------------------------------

-- 1차 결과 코드에서, 
-- 앞쪽에(`) 백틱 3개 있고, 맨 마지막에도 (`) 백틱3개 있음
-- 여기서 마지막 백틱 3개는 삭제.

```mermaid
erDiagram
    USERS {
        NUMBER USER_ID PK
        VARCHAR2 USERNAME
        VARCHAR2 PASSWORD
        VARCHAR2 EMAIL
        VARCHAR2 PHONE
        VARCHAR2 ADDRESS
        DATE CREATED_AT
    }
    POSTS {
        NUMBER POST_ID PK
        NUMBER USER_ID FK
        VARCHAR2 TITLE
        CLOB CONTENT
        DATE CREATED_AT
    }
    COMMENTS {
        NUMBER COMMENT_ID PK
        NUMBER POST_ID FK
        NUMBER USER_ID FK
        VARCHAR2 CONTENT
        DATE CREATED_AT
    }
    PRODUCTS {
        NUMBER PRODUCT_ID PK
        VARCHAR2 NAME
        VARCHAR2 DESCRIPTION
        NUMBER PRICE
        NUMBER STOCK
        DATE CREATED_AT
    }
    PRODUCT_IMAGES {
        NUMBER IMAGE_ID PK
        NUMBER PRODUCT_ID FK
        VARCHAR2 IMAGE_URL
    }
    CARTS {
        NUMBER CART_ID PK
        NUMBER USER_ID FK
        DATE CREATED_AT
    }
    CART_ITEMS {
        NUMBER CART_ITEM_ID PK
        NUMBER CART_ID FK
        NUMBER PRODUCT_ID FK
        NUMBER QUANTITY
    }
    ORDERS {
        NUMBER ORDER_ID PK
        NUMBER USER_ID FK
        DATE ORDER_DATE
        VARCHAR2 STATUS
    }
    ORDER_ITEMS {
        NUMBER ORDER_ITEM_ID PK
        NUMBER ORDER_ID FK
        NUMBER PRODUCT_ID FK
        NUMBER QUANTITY
        NUMBER PRICE
    }
    PAYMENTS {
        NUMBER PAYMENT_ID PK
        NUMBER ORDER_ID FK
        DATE PAYMENT_DATE
        NUMBER AMOUNT
        VARCHAR2 METHOD
        VARCHAR2 STATUS
    }
    DELIVERIES {
        NUMBER DELIVERY_ID PK
        NUMBER ORDER_ID FK
        VARCHAR2 ADDRESS
        DATE DELIVERY_DATE
        VARCHAR2 STATUS
    }

    USERS ||--o{ POSTS : "writes"
    USERS ||--o{ COMMENTS : "writes"
    USERS ||--o{ CARTS : "has"
    USERS ||--o{ ORDERS : "places"
    POSTS ||--o{ COMMENTS : "has"
    PRODUCTS ||--o{ PRODUCT_IMAGES : "has"
    CARTS ||--o{ CART_ITEMS : "contains"
    PRODUCTS ||--o{ CART_ITEMS : "in"
    ORDERS ||--o{ ORDER_ITEMS : "contains"
    PRODUCTS ||--o{ ORDER_ITEMS : "ordered"
    ORDERS ||--o{ PAYMENTS : "paid by"
    ORDERS ||--o{ DELIVERIES : "delivered by"

----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------

-- 2) DFD 다이어그램 코드 만들어줘
-- 앞쪽에(`) 백틱 3개 있고, 맨 마지막에도 (`) 백틱3개 있음
-- 여기서 마지막 백틱 3개는 삭제.

```mermaid
flowchart TD
    %% DFD(데이터 흐름도) - 쇼핑몰 예시

    %% 외부 엔터티
    Customer((고객))
    Admin((관리자))

    %% 프로세스
    P1[회원가입/로그인]
    P2[상품 조회/검색]
    P3[장바구니 관리]
    P4[주문/결제]
    P5[배송 관리]
    P6[게시글/댓글 관리]

    %% 데이터 저장소
    D1[(USERS)]
    D2[(PRODUCTS)]
    D3[(CARTS & CART_ITEMS)]
    D4[(ORDERS & ORDER_ITEMS)]
    D5[(PAYMENTS)]
    D6[(DELIVERIES)]
    D7[(POSTS & COMMENTS)]
    D8[(PRODUCT_IMAGES)]

    %% 고객 흐름
    Customer -- 회원정보 입력/로그인 --> P1
    P1 -- 회원정보 저장/조회 --> D1

    Customer -- 상품검색/조회 --> P2
    P2 -- 상품정보 조회 --> D2
    P2 -- 상품이미지 조회 --> D8

    Customer -- 장바구니 추가/수정 --> P3
    P3 -- 장바구니 저장/조회 --> D3

    Customer -- 주문/결제 요청 --> P4
    P4 -- 주문정보 저장/조회 --> D4
    P4 -- 결제정보 저장/조회 --> D5

    P4 -- 배송정보 요청 --> P5
    P5 -- 배송정보 저장/조회 --> D6

    Customer -- 게시글/댓글 작성 --> P6
    P6 -- 게시글/댓글 저장/조회 --> D7

    %% 관리자 흐름
    Admin -- 상품 등록/수정 --> P2
    P2 -- 상품정보 저장/조회 --> D2
    Admin -- 배송상태 변경 --> P5
    P5 -- 배송정보 저장/조회 --> D6

----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
-- gist.github.com 사이트 접속, 로그인
-- README.md 파일을 만들어서,
-- 위의 코드를 복사 할 예정.
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
-- 같은 형식으로,
-- 2) DFD 다이어그램 코드 만들어줘
-- 3) 시퀀스 다이어그램 코드 만들어줘

-- gist.github.com 사이트 접속, 로그인
-- README.md 파일을 만들어서,
-- 위의 코드를 복사 할 예정.
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
-- 3) 시퀀스 다이어그램 코드 만들어줘
-- 앞쪽에(`) 백틱 3개 있고, 맨 마지막에도 (`) 백틱3개 있음
-- 여기서 마지막 백틱 3개는 삭제.

```mermaid
sequenceDiagram
    participant 고객
    participant 웹사이트
    participant DB

    고객->>웹사이트: 회원가입/로그인 요청
    웹사이트->>DB: USERS 테이블 저장/조회
    DB-->>웹사이트: 회원정보 결과 반환
    웹사이트-->>고객: 회원가입/로그인 결과

    고객->>웹사이트: 상품 목록/검색 요청
    웹사이트->>DB: PRODUCTS, PRODUCT_IMAGES 조회
    DB-->>웹사이트: 상품/이미지 데이터 반환
    웹사이트-->>고객: 상품 목록/상세 정보 제공

    고객->>웹사이트: 장바구니 담기/수정
    웹사이트->>DB: CARTS, CART_ITEMS 저장/수정
    DB-->>웹사이트: 장바구니 결과 반환
    웹사이트-->>고객: 장바구니 상태 안내

    고객->>웹사이트: 주문/결제 요청
    웹사이트->>DB: ORDERS, ORDER_ITEMS, PAYMENTS 저장
    DB-->>웹사이트: 주문/결제 결과 반환
    웹사이트-->>고객: 주문/결제 완료 안내

    웹사이트->>DB: DELIVERIES 저장/조회
    DB-->>웹사이트: 배송정보 반환
    웹사이트-->>고객: 배송상태 안내

    고객->>웹사이트: 게시글/댓글 작성
    웹사이트->>DB: POSTS, COMMENTS 저장
    DB-->>웹사이트: 게시글/댓글 결과 반환
    웹사이트-->>고객: 작성 완료 안내

-- 스크립트 형식으로 확인도 가능
<script src="https://gist.github.com/chanwoo97/a15e6d87cd37374c2b12e7db30fae507.js"></script>
----------------------------------------------------------------------------------------------------------------------------


-- 깃스트에서, 임베디드 코드 복사해서, 
-- ex_gist.html 파일 생성후
-- 코드 붙여 넣고 확인해보기

