using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.R1
{
	public class Scenery : ObjectDefinition
	{
		private struct SceneryData
		{
			public string name;
			public Sprite sprite;

			public SceneryData(string name, Sprite sprite)
			{
				this.name = name;
				this.sprite = sprite;
			}
		}

		private SceneryData[] scenery;

		public override void Init(ObjectData data)
		{
			scenery = new SceneryData[3];
			
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/scenery_b.nem", CompressionType.Nemesis);
			scenery[0] = new SceneryData(
				"Branch 1 (Past)",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/scenery.asm", 0, 2));
			scenery[1] = new SceneryData(
				"Branch 2 (Past)",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/scenery.asm", 1, 2));

			art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/scenery_cd.nem", CompressionType.Nemesis);
			scenery[2] = new SceneryData(
				"Stem (Future)",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/scenery.asm", 2, 2));
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new byte[] { 0, 1, 2 }); }
		}

		public override string Name
		{
			get { return "Scenery"; }
		}

		public override bool RememberState
		{
			get { return false; }
		}

		public override string SubtypeName(byte subtype)
		{
			return scenery[subtype].name;
		}

		public override Sprite Image
		{
			get { return scenery[0].sprite; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return scenery[subtype].sprite;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return new Sprite(scenery[obj.SubType].sprite, obj.XFlip, obj.YFlip);
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 0;
		}
	}
}
