let project = new Project('SDF Demo');
project.addSources('Sources');
await project.addProject("Libraries/kha-sdf-painter/");
resolve(project);
