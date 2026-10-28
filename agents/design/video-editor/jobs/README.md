# Autonomous job queue
Place a JSON file here and commit it with an input media file inside ../media/. GitHub Actions scheduled workflow checks for jobs and renders any whose output is not yet present in the current checkout. Workflow artifacts expire per GitHub retention settings.
Example: {"id":"demo-001","input":"agents/design/video-editor/media/demo.mp4","format":"short"}
No job is currently queued. This baseline runner reframes/encodes only. Advanced creative editing requires real media, transcription/EDL, and connected tools.
