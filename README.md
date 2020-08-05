# HashCheck
 Compare directories using hashes against an intermediate file

## Usage
### Create hash file
```ps
hashcheck.ps1 -generatehash -hashdir <directory to hash> -hashfile <file to store hashes>
```

### Compare directory against intermediate hash file
```ps
hashcheck.ps1 -hashfile <file read hashes>
```