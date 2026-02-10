#=============================================================================
# [Stage 1] Build Stage
#=============================================================================
FROM gradle:8.5-jdk17 AS builder

WORKDIR /build

# Gradle 설정 파일 복사
COPY build.gradle settings.gradle ./

# 빈 src 디렉토리 생성
RUN mkdir -p src/main/java src/main/resources

# 의존성 다운로드
RUN gradle dependencies --no-daemon || true

# 소스 코드 복사
COPY src ./src

# 빌드
RUN gradle clean bootJar --no-daemon

#=============================================================================
# [Stage 2] Runner Stage
#=============================================================================
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=builder /build/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]