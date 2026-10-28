import { spawnSync } from 'node:child_process';
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { resolve, dirname, extname } from 'node:path';

const root = process.cwd();
const jobsDir = resolve(root, 'agents/design/video-editor/jobs');
const jobFile = process.argv[2];
if (!jobFile) { console.error('Usage: node runner.mjs <job.json>'); process.exit(2); }
const file = resolve(root, jobFile);
if (!file.startsWith(jobsDir + '/') || extname(file) !== '.json') throw Error('Job must be JSON in jobs directory');
const job = JSON.parse(readFileSync(file, 'utf8'));
if (!/^[a-zA-Z0-9_-]{1,60}$/.test(job.id)) throw Error('Invalid job id');
if (!['short','long'].includes(job.format)) throw Error('Invalid format');
const src = resolve(root, job.input);
const mediaRoot = resolve(root, 'agents/design/video-editor/media');
if (!src.startsWith(mediaRoot + '/') || !existsSync(src)) throw Error('Input must exist inside media/');
const outDir = resolve(root, 'agents/design/video-editor/outputs');
mkdirSync(outDir, { recursive:true });
const output = resolve(outDir, job.id + '.mp4');
const args = ['-hide_banner','-nostdin','-y','-i',src];
if (job.format === 'short') {
  args.push('-vf',"scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,setsar=1");
} else {
  args.push('-vf',"scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1");
}
args.push('-c:v','libx264','-preset','medium','-crf','20','-pix_fmt','yuv420p','-c:a','aac','-b:a','192k','-movflags','+faststart',output);
const run = spawnSync('ffmpeg',args,{stdio:'inherit',timeout:30*60*1000});
if (run.status !== 0) throw Error('FFmpeg render failed');
const probe = spawnSync('ffprobe',['-v','error','-show_entries','format=duration:stream=codec_name,width,height','-of','json',output],{encoding:'utf8'});
if (probe.status !== 0) throw Error('Output validation failed');
const report = {id:job.id,source:job.input,output,probe:JSON.parse(probe.stdout),limitations:'Automated formatting only; no transcript-based edits, captions or motion graphics without a configured production pipeline.'};
writeFileSync(resolve(outDir,job.id+'.json'),JSON.stringify(report,null,2));
console.log('Rendered',output);
