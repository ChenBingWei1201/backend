-- CreateTable
CREATE TABLE "Announcement" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "content" TEXT NOT NULL,

    CONSTRAINT "Announcement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "studentID" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "photoLink" TEXT NOT NULL,
    "introduction" TEXT,
    "questionsId" INTEGER[],
    "questionCommentsId" INTEGER[],
    "solutionsId" INTEGER[],
    "solutionCommentsId" INTEGER[],
    "articlesId" INTEGER[],
    "articleCommentsId" INTEGER[],
    "likedQuestionsId" INTEGER[],
    "likedQuestionCommentsId" INTEGER[],
    "likedSolutionsId" INTEGER[],
    "likedSolutionCommentsId" INTEGER[],
    "likedArticlesId" INTEGER[],
    "likedArticleCommentsId" INTEGER[],

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Question" (
    "id" SERIAL NOT NULL,
    "askerId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "topic" TEXT NOT NULL,
    "tags" TEXT[],
    "commentsId" INTEGER[],
    "solutionsId" INTEGER[],
    "likesId" INTEGER[],

    CONSTRAINT "Question_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QuestionComment" (
    "id" SERIAL NOT NULL,
    "commenterId" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "rootQuestionId" INTEGER NOT NULL,
    "date" TEXT NOT NULL,
    "likesId" INTEGER[],

    CONSTRAINT "QuestionComment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Solution" (
    "id" SERIAL NOT NULL,
    "date" TEXT NOT NULL,
    "solverId" INTEGER NOT NULL,
    "rootQuestionId" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "likesId" INTEGER[],
    "commentsId" INTEGER[],

    CONSTRAINT "Solution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SolutionComment" (
    "id" SERIAL NOT NULL,
    "commenterId" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "rootSolutionId" INTEGER NOT NULL,
    "date" TEXT NOT NULL,
    "likesId" INTEGER[],

    CONSTRAINT "SolutionComment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Article" (
    "id" SERIAL NOT NULL,
    "writerId" INTEGER NOT NULL,
    "date" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "tags" TEXT[],
    "topic" TEXT NOT NULL,
    "commentsId" INTEGER[],
    "likesId" INTEGER[],

    CONSTRAINT "Article_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ArticleComment" (
    "id" SERIAL NOT NULL,
    "commenterId" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "rootArticleId" INTEGER NOT NULL,
    "likesId" INTEGER[],

    CONSTRAINT "ArticleComment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LikedQuestion" (
    "id" SERIAL NOT NULL,
    "likerId" INTEGER NOT NULL,
    "questionId" INTEGER NOT NULL,

    CONSTRAINT "LikedQuestion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LikedQuestionComment" (
    "id" SERIAL NOT NULL,
    "likerId" INTEGER NOT NULL,
    "questionCommentId" INTEGER NOT NULL,

    CONSTRAINT "LikedQuestionComment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LikedSolution" (
    "id" SERIAL NOT NULL,
    "likerId" INTEGER NOT NULL,
    "solutionId" INTEGER NOT NULL,

    CONSTRAINT "LikedSolution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LikedSolutionComment" (
    "id" SERIAL NOT NULL,
    "likerId" INTEGER NOT NULL,
    "solutionCommentId" INTEGER NOT NULL,

    CONSTRAINT "LikedSolutionComment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LikedArticle" (
    "id" SERIAL NOT NULL,
    "likerId" INTEGER NOT NULL,
    "articleId" INTEGER NOT NULL,

    CONSTRAINT "LikedArticle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LikedArticleComment" (
    "id" SERIAL NOT NULL,
    "likerId" INTEGER NOT NULL,
    "articleCommentId" INTEGER NOT NULL,

    CONSTRAINT "LikedArticleComment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_studentID_password_key" ON "User"("studentID", "password");

-- AddForeignKey
ALTER TABLE "Question" ADD CONSTRAINT "Question_askerId_fkey" FOREIGN KEY ("askerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuestionComment" ADD CONSTRAINT "QuestionComment_commenterId_fkey" FOREIGN KEY ("commenterId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuestionComment" ADD CONSTRAINT "QuestionComment_rootQuestionId_fkey" FOREIGN KEY ("rootQuestionId") REFERENCES "Question"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Solution" ADD CONSTRAINT "Solution_solverId_fkey" FOREIGN KEY ("solverId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Solution" ADD CONSTRAINT "Solution_rootQuestionId_fkey" FOREIGN KEY ("rootQuestionId") REFERENCES "Question"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SolutionComment" ADD CONSTRAINT "SolutionComment_commenterId_fkey" FOREIGN KEY ("commenterId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SolutionComment" ADD CONSTRAINT "SolutionComment_rootSolutionId_fkey" FOREIGN KEY ("rootSolutionId") REFERENCES "Solution"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Article" ADD CONSTRAINT "Article_writerId_fkey" FOREIGN KEY ("writerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ArticleComment" ADD CONSTRAINT "ArticleComment_commenterId_fkey" FOREIGN KEY ("commenterId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ArticleComment" ADD CONSTRAINT "ArticleComment_rootArticleId_fkey" FOREIGN KEY ("rootArticleId") REFERENCES "Article"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedQuestion" ADD CONSTRAINT "LikedQuestion_likerId_fkey" FOREIGN KEY ("likerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedQuestion" ADD CONSTRAINT "LikedQuestion_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "Question"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedQuestionComment" ADD CONSTRAINT "LikedQuestionComment_likerId_fkey" FOREIGN KEY ("likerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedQuestionComment" ADD CONSTRAINT "LikedQuestionComment_questionCommentId_fkey" FOREIGN KEY ("questionCommentId") REFERENCES "QuestionComment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedSolution" ADD CONSTRAINT "LikedSolution_likerId_fkey" FOREIGN KEY ("likerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedSolution" ADD CONSTRAINT "LikedSolution_solutionId_fkey" FOREIGN KEY ("solutionId") REFERENCES "Solution"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedSolutionComment" ADD CONSTRAINT "LikedSolutionComment_likerId_fkey" FOREIGN KEY ("likerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedSolutionComment" ADD CONSTRAINT "LikedSolutionComment_solutionCommentId_fkey" FOREIGN KEY ("solutionCommentId") REFERENCES "SolutionComment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedArticle" ADD CONSTRAINT "LikedArticle_likerId_fkey" FOREIGN KEY ("likerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedArticle" ADD CONSTRAINT "LikedArticle_articleId_fkey" FOREIGN KEY ("articleId") REFERENCES "Article"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedArticleComment" ADD CONSTRAINT "LikedArticleComment_likerId_fkey" FOREIGN KEY ("likerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LikedArticleComment" ADD CONSTRAINT "LikedArticleComment_articleCommentId_fkey" FOREIGN KEY ("articleCommentId") REFERENCES "ArticleComment"("id") ON DELETE CASCADE ON UPDATE CASCADE;
