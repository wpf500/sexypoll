name := "ballot-box"

version := "1.0-SNAPSHOT"

lazy val root = (project in file(".")).enablePlugins(PlayScala)

libraryDependencies += "com.github.seratch" %% "awscala" % "0.2.+"